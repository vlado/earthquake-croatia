# frozen_string_literal: true

class Ads::DeleteController < ApplicationController
  def new
    @ad = Ad.active.find(params[:ad_id])
    redirect_to ad_path(@ad), alert: "Nedozvoljena akcija." if token_invalid?
  end

  private

  def token_invalid?
    params[:t].blank? || @ad.token != params[:t]
  end
end
