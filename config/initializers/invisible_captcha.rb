# Be sure to restart your server when you modify this file.

InvisibleCaptcha.setup do |config|
  config.timestamp_enabled = !Rails.env.test?
end
