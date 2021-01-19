# frozen_string_literal: true

# A class to implement all logic related to sending of reminder e-mails
class AdReminder
  include Rails.application.routes.url_helpers

  def remind_oldest(batch_size)
    Ad.with_email.not_deleted.not_reminded.expiring.order(created_at: :asc).limit(batch_size).each do |ad|
      ad.refresh_token!
      AdMailer.send_reminder(
        ad,
        ad_url(ad),
        edit_ad_url(ad, t: ad.token),
        new_ad_delete_url(ad, t: ad.token)
      ).deliver
    end
  end
end
