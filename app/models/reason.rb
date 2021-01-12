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
class Reason < ApplicationRecord
  belongs_to :ad

  DELETE_REASONS = {
    common: {
      other: 0,
    },
    demand: {
      got_help_here: 1,
      got_help_elsewhere: 2,
      solved_problem_ourselves: 3,
    },
    supply: {
      gave_help_here: 4,
      gave_help_elsewhere: 5,
      cannot_give_help_anymore: 6,
    },
  }.freeze

  enum code: DELETE_REASONS.values.reduce(&:merge)
end
