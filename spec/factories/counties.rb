# frozen_string_literal: true

FactoryBot.define do
  factory :county do
    sequence(:name) { |n| "County #{n}" }
  end
end
