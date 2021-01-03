# frozen_string_literal: true

require "test_helper"
require "ffaker"
require "rake"

class NormalizeCityNameTest < ActiveSupport::TestCase
  test "converts current city names correctly" do
    JSON[File.read(Rails.root.join('old_cities.json'))].each do |city_name|
      ad = Ad.new(
        city: city_name,
        zip: rand(10_000..99_000),
        phone: '0' + rand(9_000_00_00..9_999_99_99).to_s,
        description: FFaker::Lorem.paragraph,
        email: FFaker::Internet.email,
        kind: Ad::KINDS.sample,
        consent: true,
        address: FFaker::Address.street_name
      )
      ad.save!(validate: false)
    end

    Rake::Task["ads:normalize_city_names"].invoke
    File.write(Rails.root.join('new_cities.json'), Ad.pluck(:city).uniq.sort.to_json)
  end
end
