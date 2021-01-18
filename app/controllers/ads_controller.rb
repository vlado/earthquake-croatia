# frozen_string_literal: true

class AdsController < ApplicationController
  invisible_captcha only: [:create], honeypot: :title

  def index
    @ads = Ad
      .for_index_page(kind: ad_kind, category: params[:category], city_id: params[:city_id])
      .paginate(page: params[:page], per_page: 20)
  end

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
    redirect_to ad_path(@ad), alert: t("ad.edit_not_allowed") if token_invalid?
  end

  def update
    @ad = Ad.active.find(params[:id])

    if token_valid? && @ad.update(ad_params)
      redirect_to ad_path(@ad), notice: "Izmjene spremljene"
    else
      flash.now[:alert] = t("ad.edit_not_allowed") if token_invalid?
      render :edit
    end
  end

  def destroy
    @ad = Ad.active.find(params[:id])
    redirect_to ad_path(@ad), alert: t("ad.delete_not_allowed") if token_invalid?

    @ad.soft_delete!(params[:delete_reason], params[:delete_comment])
    redirect_to ads_path, notice: "Oglas obrisan."
  end

  private

  def ad_params
    params.require(:ad).permit(:kind, :city_id, :description, :email, :phone, :zip, :consent, :address, :category)
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
