# frozen_string_literal: true

class AdsController < ApplicationController
  invisible_captcha only: [:create], honeypot: :title

  # rubocop:disable Metrics/AbcSize
  def index
    @ads = Ad.where(kind: ad_kind).order(created_at: :desc).paginate(page: params[:page], per_page: 20)
    @ads = @ads.where(category: params[:category]) if params[:category].present?
    @ads = @ads.where(city_id: params[:city_id]) if params[:city_id].present?
  end
  # rubocop:enable Metrics/AbcSize

  def new
    @ad = Ad.new(kind: ad_kind)
  end

  def show
    @ad = Ad.find(params[:id])
  end

  def create
    @ad = Ad.new(ad_params)
    if @ad.save
      redirect_to ads_path(kind: @ad.kind), notice: "Oglas uspješno dodan!"
    else
      render :new
    end
  end

  private

  def ad_params
    params.require(:ad).permit(:kind, :city_id, :description, :email, :phone, :zip, :consent, :address, :category)
  end

  def ad_kind
    Ad.kinds.keys.include?(params[:kind]) ? params[:kind] : Ad.kinds.keys.first
  end
  helper_method :ad_kind
end
