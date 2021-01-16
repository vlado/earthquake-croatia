# frozen_string_literal: true

FactoryBot.define do
  factory :ad do
    address { "Somewhere far away" }
    city
    consent { true }
    description { "Some description." }
    sequence(:kind) { |n| Ad::KINDS[n % Ad::KINDS.size] }
    sequence(:category) { |n| Ad::CATEGORIES[n % Ad::CATEGORIES.size] }
    sequence(:phone) { |n| "098/555-#{n}" }

    trait :deleted do
      deleted_at { Time.zone.now }
    end

    trait :with_email do
      sequence(:email) { |n| "tester#{n}@example.com" }
    end
  end
end
