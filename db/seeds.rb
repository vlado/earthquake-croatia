# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "ffaker"

ads_data = []
number_of_ads = 500

county = County.create!(name: "SISAČKO-MOSLAVAČKA")
City.create!(name: "Petrinja", county: county)
City.create!(name: "Glina", county: county)
City.create!(name: "Sisak", county: county)

cities = City.pluck(:id)
time_of_creation = Time.now
number_of_ads.times do
  ads_data << {
    city_id: cities.sample,
    phone: '0' + rand(9_000_00_00..9_999_99_99).to_s,
    description: FFaker::Lorem.paragraph,
    email: rand < 0.4 ? FFaker::Internet.email : nil, # 40% chance ad has email
    kind: Ad::KINDS.sample,
    consent: true,
    address: FFaker::Address.street_name,
    category: Ad::CATEGORIES.sample,
    created_at: time_of_creation,
    updated_at: time_of_creation
  }
end

Ad.insert_all!(ads_data)

puts "Generated %d ads" % [number_of_ads]
