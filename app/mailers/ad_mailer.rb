# frozen_string_literal: true

class AdMailer < ApplicationMailer
  default from: "do-not-reply@potres-petrinja.hr"

  def send_token(ad, action, url)
    @action = I18n.t("tokens.action.#{action}")
    @url = url
    mail to: ad.email, subject: "Link za #{@action} oglasa"
  end

  def send_reminder(ad, ad_link, edit_url, delete_url)
    @creation_date = ad.created_at.to_date
    @ad_link = ad_link
    @edit_url = edit_url
    @delete_url = delete_url
    mail to: ad.email, subject: "Vaš oglas na potres-petrinja.hr"
  end
end
