# frozen_string_literal: true

# == Schema Information
#
# Table name: ads
#
#  id          :bigint           not null, primary key
#  address     :string
#  city        :string
#  consent     :boolean
#  description :text
#  email       :string
#  kind        :string
#  phone       :string
#  zip         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Ad < ApplicationRecord
  KINDS = ["Smještaj", "Prijevoz", "Usluga popravka", "Medicinska pomoć"].freeze

  validates :city, presence: true
  validates :description, presence: true
  validates :phone, presence: true, on: %i[create update]
  validates :kind, presence: true, inclusion: { in: KINDS }
  validates :consent, presence: { message: "mora biti odobrena" }
  validates :address, presence: { message: "ne smije biti prazna" }, on: %i[create update]
  validates :email, format: /@/, if: -> { email.present? }

  def accomodation?
    kind == "Smještaj"
  end

  def transportation?
    kind == "Prijevoz"
  end

  def repair_service?
    kind == "Usluga popravka"
  end

  def medical_help?
    kind == "Medicinska pomoć"
  end

  def to_param
    [id, kind.parameterize, city.parameterize].join("-")
  end

  def full_address
    zip_and_city = [zip, city].select(&:present?).join(" ")
    [address, zip_and_city].join(", ")
  end
end
