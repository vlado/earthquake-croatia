# frozen_string_literal: true

class AdsController < ApplicationController
  invisible_captcha only: [:create], honeypot: :title

  # rubocop:disable Metrics/AbcSize
  def index
    @ads = Ad.active.where(kind: ad_kind).order(created_at: :desc).paginate(page: params[:page], per_page: 20)
    @ads = @ads.where(category: params[:category]) if params[:category].present?
    @ads = @ads.where(city: params[:city]) if params[:city].present?
  end
  # rubocop:enable Metrics/AbcSize

  def new
    @ad = Ad.new(kind: ad_kind)
  end

  def show
    @ad = Ad.active.find(params[:id])
  end

  def create
    @ad = Ad.new(ad_params)
    if @ad.save
      redirect_to ads_path(kind: @ad.kind), notice: "Oglas uspješno dodan!"
    else
      render :new
    end
  end

  def edit
    @ad = Ad.active.find(params[:id])
    redirect_to ad_path(@ad), alert: "Nedozvoljena akcija." if token_invalid?
  end

  def update
    @ad = Ad.active.find(params[:id])

    if token_valid? && @ad.update(ad_params)
      redirect_to ad_path(@ad), notice: "Izmjene spremljene"
    else
      flash.now[:alert] = "Nedozvoljena akcija." if token_invalid?
      render :edit
    end
  end

  def destroy
    @ad = Ad.active.find(params[:id])
    redirect_to ad_path(@ad), alert: "Nedozvoljena akcija." if token_invalid?

    @ad.soft_delete!
    redirect_to ads_path, notice: "Oglas obirsan."
  end

  private

  def ad_params
    params.require(:ad).permit(:kind, :city, :description, :email, :phone, :zip, :consent, :address, :category)
  end

  def ad_kind
    Ad.kinds.keys.include?(params[:kind]) ? params[:kind] : Ad.kinds.keys.first
  end
  helper_method :ad_kind

  def token_valid?
    @ad.token_valid?(params[:t])
  end

  def token_invalid?
    !token_valid?
  end
end
