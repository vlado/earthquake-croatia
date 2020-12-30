module AdsHelper
  def city_and_zip(ad)
    items = [ad.city]
    items << tag.span(ad.zip, class: "is-size-7") if ad.zip.present?
    sanitize(items.join(", "))
  end

  def filtered?
    params[:kind].present? || params[:city].present?
  end

  def kind_tag(ad)
    color_class = if ad.accomodation?
                  'is-success'
                elsif ad.transportation?
                  'is-info'
                elsif ad.repair_service?
                  'is-warning'
                elsif ad.medical_help?
                  'is-danger'
                else
                  'is-white'
                end

    tag.span(ad.kind, class: "tag #{color_class}")
  end

  def maps_url(location)
    "https://google.com/maps/place/#{location}"
  end
end
