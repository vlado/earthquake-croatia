# frozen_string_literal: true

module NormalizeCityName
  extend ActiveSupport::Concern

  included do
    before_validation :normalize_city_name

    def normalize_city_name
      return if city.blank?

      self.city = city.squish
      # if it's only one word, make sure it's not ALLCAPS
      self.city = if city.split(/[^[[:word:]]]+/).size == 1
                    city.titleize
                  else
                    city.upcase_first
                  end

      normalize_from_yml || normalize_from_other_db_records
    end

    private

    def normalize_from_yml
      cities_mapping = YAML.load_file(Rails.root.join("lib/tasks/cities_mapping.yml"))["cities"]
      return false unless cities_mapping[city]

      self.city = cities_mapping[city]
      true
    end

    def normalize_from_other_db_records
      normalized_record = Ad.find_by("unaccent(city) ILIKE unaccent(?)", city)
      self.city = normalized_record.city if normalized_record.present?
    end
  end
end
