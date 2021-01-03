# == Schema Information
#
# Table name: cities
#
#  id         :bigint           not null, primary key
#  name       :string
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
require "test_helper"

class CityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
