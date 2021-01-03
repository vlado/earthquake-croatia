# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ads_data = []
number_of_ads = 500

number_of_ads.times do
  ads_data << {
    city: City.find(rand(1..(City.count-1))),
    zip: rand(10_000..99_000),
    phone: '0' + rand(9_000_00_00..9_999_99_99).to_s,
    description: FFaker::Lorem.paragraph,
    email: rand(0..number_of_ads) < 40 ? FFaker::Internet.email : nil, # 40% chance ad has email
    kind: Ad::KINDS.sample,
    consent: true,
    address: FFaker::Address.street_name,
    service: Ad::SERVICES[rand(Ad::SERVICES.count-1)]
  }
end

Ad.create!(ads_data)

puts "Generated %d ads" % [number_of_ads]
