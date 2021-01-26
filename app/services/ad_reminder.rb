# frozen_string_literal: true

# A class to implement all logic related to sending of reminder e-mails
class AdReminder
  include Rails.application.routes.url_helpers

  def remind_oldest(batch_size)
    Ad.with_email.not_deleted.not_reminded.expiring.order(created_at: :asc).limit(batch_size).each do |ad|
      remind_ad(ad)
    end
  end

  private

  def remind_ad(ad)
    ad.refresh_token!
    AdMailer.send_reminder(
      ad,
      ad_url(ad),
      edit_ad_url(ad, t: ad.token),
      new_ad_delete_url(ad, t: ad.token)
    ).deliver
    ad.update!(reminder_sent_at: Time.zone.now)
  rescue StandardError => e
    Rails.logger.debug "Errror while trying to remind Ad##{ad.id}: #{e.message}"
  end
end
