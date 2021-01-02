# frozen_string_literal: true

module ApplicationHelper
  def tel_to(phone)
    link_to(phone, "tel:#{phone}")
  end

  def class_if(klass, boolean = false)
    klass if boolean
  end

  def flash_class(type)
    { "notice" => "is-success", "error" => "is-danger", "alert" => "is-warning" }[type]
  end
end
