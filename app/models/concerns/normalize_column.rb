# frozen_string_literal: true

module NormalizeColumn
  extend ActiveSupport::Concern

  included do
    def self.normalize_column(column_name)
      before_validation -> do # rubocop:disable Style/Lambda
        value = self[column_name]
        next unless value

        value = value.squish
        # if it's only one word, make sure it's not ALLCAPS
        value = if value.split(/[^[[:word:]]]+/).size == 1
                  value.titleize
                else
                  value.upcase_first
                end
        # here we can interpolate `column_name` in a db query, as that comes from our app, not from user input
        normalized_record = self.class.find_by("unaccent(#{column_name}) ILIKE unaccent(?)", value)
        self[column_name] = normalized_record[column_name] if normalized_record.present?
      end
    end
  end
end
