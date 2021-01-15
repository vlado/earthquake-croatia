# frozen_string_literal: true

FactoryBot.define do
  factory :city do
    area_name { "some area" }
    county { build(:county) }
    name { "some city" }
  end
end
