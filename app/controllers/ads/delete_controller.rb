# frozen_string_literal: true

class Ads::DeleteController < ApplicationController
  def new
    @ad = Ad.active.find(params[:ad_id])
    redirect_to ad_path(@ad), alert: t("ad.delete_not_allowed") unless @ad.token_valid?(params[:t])
  end
end
