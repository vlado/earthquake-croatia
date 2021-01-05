# frozen_string_literal: true

# == Schema Information
#
# Table name: counties
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_counties_on_name  (name)
#
require "test_helper"

class CountyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
