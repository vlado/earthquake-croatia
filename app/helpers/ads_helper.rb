# frozen_string_literal: true

module AdsHelper
  def city_and_zip(ad)
    items = [ad.city]
    items << tag.span(ad.zip, class: "is-size-7") if ad.zip.present?
    sanitize(items.join(", "))
  end

  def filtered?
    params[:category].present? || params[:city].present?
  end

  def categories_for_select
    %w[
      accomodation
      transport
      building_material
      kids
      diet_and_hygiene
      furniture_and_household
      clothes_and_shoes
      repairs
      medical_assistance
      other
    ].map { |key| [t("ad.categories.#{key}"), key] }
  end

  def kinds_for_select
    Ad.kinds.keys.map { |key| [t("ad.kinds.#{key}"), key] }
  end

  def cities_for_filter_select
    City.where(id: Ad.select("DISTINCT(city_id)")).order(:name).pluck(:name, :id)
  end

  def category_tag(ad)
    mapping = {
      "accomodation" => "is-success",
      "transport" => "is-info",
      "building_material" => "is-dark",
      "kids" => "is-primary",
      "diet_and_hygiene" => "is-link",
      "furniture_and_household" => "is-dark",
      "clothes_and_shoes" => "is-black",
      "repairs" => "is-warning",
      "medical_assistance" => "is-danger",
      "other" => "is-light",
    }

    color_class = mapping.fetch(ad.category, "is-white")
    tag.span(t("ad.categories.#{ad.category}"), class: "tag #{color_class}")
  end

  def maps_url(location)
    "https://google.com/maps/place/#{location}"
  end
end
