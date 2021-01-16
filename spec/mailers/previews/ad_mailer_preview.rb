# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/ad_mailer
class AdMailerPreview < ActionMailer::Preview
  def send_token
    ad = Ad.new(id: 123, token: "a1b2c3d4", email: "tester@example.com")
    action = params[:a].presence || "edit"
    AdMailer.send_token(ad, action, "http://www.example.com/ads/123/edit?t=a1b2c3d4")
  end

  def send_reminder
    ad = Ad.new(id: 123, token: "a1b2c3d4", email: "tester@example.com", created_at: Time.zone.now)
    AdMailer.send_reminder(
      ad,
      "http://www.example.com/ads/123",
      "http://www.example.com/ads/123/edit?t=a1b2c3d4",
      "http://www.example.com/ads/123/token/new?t=a1b2c3d4"
    )
  end
end
