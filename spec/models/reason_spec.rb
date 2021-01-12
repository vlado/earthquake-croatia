# frozen_string_literal: true

# == Schema Information
#
# Table name: reasons
#
#  id         :bigint           not null, primary key
#  code       :integer
#  comment    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ad_id      :bigint           not null
#
# Indexes
#
#  index_reasons_on_ad_id  (ad_id)
#
require "rails_helper"

RSpec.describe Reason, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
