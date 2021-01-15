# frozen_string_literal: true

json.array! @ads do |ad|
  json.extract! ad, :id, :kind, :category, :address, :zip, :phone, :description
  json.city ad.city.name
end
