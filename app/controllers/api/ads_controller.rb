# frozen_string_literal: true

class Api::AdsController < ApplicationController
  include Rails::Pagination # https://github.com/davidcelis/api-pagination

  MIN_PER_PAGE = 20
  MAX_PER_PAGE = 100

  def index # rubocop:disable Metrics/AbcSize
    @ads = Ad
      .active
      .strict_loading
      .includes(:city)
      .ordered
      .paginate(page: params[:page])
      .for_kind(params[:kind])
      .for_category(params[:category])
      .for_city(params[:city_id])

    paginate @ads, per_page: per_page
  end

  private

  def per_page
    value = params[:per_page].to_i
    return value if value.between?(MIN_PER_PAGE, MAX_PER_PAGE)

    value > MAX_PER_PAGE ? MAX_PER_PAGE : MIN_PER_PAGE
  end
end
