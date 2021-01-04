require 'csv'

namespace :db do

  CSV_SEED_LOCATION = Rails.root.join('db', 'fixtures', 'mjestaRh.csv')
  task seed_locations: :environment do
    locations_hash_from_csv.each do |county, locations|
      current_county = County.create(name: county)
      locations.map! { |location| location.merge({ 
                                                  county_id: current_county.id, 
                                                  created_at: Time.now,
                                                  updated_at: Time.now 
                                                }) }
      City.insert_all(locations)
    end
  end

  def locations_hash_from_csv
    {}.tap do |location_hash|
      CSV.foreach(CSV_SEED_LOCATION, encoding: 'UTF-8',col_sep: ';', headers: true) do |location|
        location_hash[location["Zupanija"]] ||= []
        location_hash[location["Zupanija"]] << {
          name: location["Naselje"],
          area_name: location["NazivPu"],
          zip_code: location["BrojPu"]
        }
      end
    end
  end

end
