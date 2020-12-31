# frozen_string_literal: true

class AdsController < ApplicationController
  invisible_captcha only: [:create], honeypot: :title

  # rubocop:disable Metrics/AbcSize
  def index
    @ads = Ad.order(created_at: :desc).paginate(page: params[:page], per_page: 20)
    @ads = @ads.where(type: ad_type)
    @ads = @ads.where(kind: params[:kind]) if params[:kind].present?
    @ads = @ads.where(city: params[:city]) if params[:city].present?
  end
  # rubocop:enable Metrics/AbcSize

  def new
    @ad = Ad.new(type: ad_type)
  end

  def show
    @ad = Ad.find(params[:id])
  end

  def create
    @ad = Ad.new(ad_params)
    if @ad.save
      redirect_to ads_path, notice: "Oglas uspješno dodan!"
    else
      render :new
    end
  end

  private

  def ad_params
    params.require(:ad).permit(:kind, :city, :description, :email, :phone, :zip, :consent, :address, :type)
  end

  def ad_type
    {
      potražnja: "potražnja",
      ponuda: "ponuda",
    }.fetch(params[:type]&.to_sym, "ponuda")
  end
end
