# frozen_string_literal: true

json.array! @ads do |ad|
  json.id ad.id
  json.kind ad.kind
  json.category ad.category
  json.address ad.address
  json.zip ad.zip
  json.city ad.city.name
  json.phone ad.phone
  json.description ad.description
end
