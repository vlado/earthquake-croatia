# == Schema Information
#
# Table name: cities
#
#  id         :bigint           not null, primary key
#  area_name  :string
#  name       :string
#  zip_code   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  county_id  :bigint
#
# Indexes
#
#  index_cities_on_county_id  (county_id)
#
# Foreign Keys
#
#  fk_rails_...  (county_id => counties.id)
#
class City < ApplicationRecord
  belongs_to :county

  def to_s
    [zip_code, name].join(" ")
  end
end
