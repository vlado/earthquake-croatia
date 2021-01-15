# frozen_string_literal: true

FactoryBot.define do
  factory :ad do
    address { "Somewhere far away" }
    city { build(:city) }
    consent { true }
    description { "Some description." }
    kind { :supply }
    phone { "09876543210" }
  end
end
