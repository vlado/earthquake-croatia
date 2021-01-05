# frozen_string_literal: true

class CitiesController < ApplicationController
  def index
    @cities = cities_search(params[:q])
    render json: { results: cities_for_select2(@cities) }
  end

  private

  def cities_for_select2(cities)
    cities.map { |city| { id: city.id, text: city.name } }
  end

  def cities_search(query)
    return City.none if query.blank? || query.length < 3

    City.strict_loading.where("name ILIKE ?", "#{query}%").select(:id, :name).limit(100)
  end
end
