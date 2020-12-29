module AdsHelper
  def city_and_zip(ad)
    items = [ad.city]
    items << tag.span(ad.zip, class: "is-size-7") if ad.zip.present?
    sanitize(items.join(", "))
  end

  def filtered?
    params[:kind].present? || params[:city].present?
  end
end
