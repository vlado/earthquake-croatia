# frozen_string_literal: true

class Ads::TokenController < ApplicationController
  ACTIONS = %w[edit delete].freeze

  def new
    @ad = Ad.active.find(params[:ad_id])
  end

  def create
    @ad = Ad.active.find(params[:ad_id])
    if valid_email_provided?
      send_token(@ad)
      redirect_to ad_path(@ad), notice: t("tokens.sent.#{action}")
    else
      flash.now[:alert] = "Email ne odgovara email adresi ostavljenoj uz oglas."
      render :new
    end
  end

  private

  def action
    raise "Invalid action provided" unless ACTIONS.include?(params[:a])

    params[:a]
  end

  def send_token(ad)
    ad.update!(token: SecureRandom.hex)
    AdMailer.send_token(ad, params[:a], build_url(ad, action)).deliver_later
  end

  def valid_email_provided?
    params[:email].present? && normalize(@ad.email) == normalize(params[:email])
  end

  def build_url(ad, action)
    if action == "delete"
      new_ad_delete_url(ad, t: ad.token)
    else
      edit_ad_url(ad, t: ad.token)
    end
  end

  def normalize(email)
    email.strip.downcase
  end
end
