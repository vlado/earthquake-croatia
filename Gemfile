
source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.1"

gem "rails", "~> 6.1.0"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "sass-rails", ">= 6"
gem "webpacker", "~> 5.0"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.7"
gem "inline_svg"

gem "bootsnap", ">= 1.4.4", require: false

group :production do
  gem "rack-canonical-host"
  gem "sentry-rails"
  gem "sentry-ruby"
end

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "rubocop-rails", "~> 2.3", ">= 2.3.1"
end

group :development do
  gem "annotate"
  gem "web-console", ">= 4.1.0"
  gem "listen", "~> 3.3"
  gem "rack-mini-profiler", "~> 2.0"
  gem "spring"

  gem "ffaker"
  gem "pry-rails"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

gem "invisible_captcha"
gem "will_paginate"
gem "will_paginate-bulma"
