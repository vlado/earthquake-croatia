class AdsController < ApplicationController
  def index
    @ads = Ad.order(created_at: :desc).paginate(page: params[:page], per_page: 100)
    @ads = @ads.where(kind: params[:kind]) if params[:kind].present?
    @ads = @ads.where(city: params[:city]) if params[:city].present?
  end

  def new
    @ad = Ad.new
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
    params.require(:ad).permit(:kind, :city, :description, :email, :phone, :zip, :consent)
  end
end
