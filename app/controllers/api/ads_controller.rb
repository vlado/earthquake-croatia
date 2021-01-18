# frozen_string_literal: true

class Api::AdsController < ApplicationController
  include Rails::Pagination # https://github.com/davidcelis/api-pagination

  MIN_PER_PAGE = 20
  MAX_PER_PAGE = 100

  def index
    @ads = Ad
      .for_index_page(kind: params[:kind], category: params[:category], city_id: params[:city_id])
      .paginate(page: params[:page])

    paginate @ads, per_page: per_page
  end

  private

  def per_page
    value = params[:per_page].to_i
    value.clamp(MIN_PER_PAGE..MAX_PER_PAGE)
  end
end
