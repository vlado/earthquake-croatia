class Ad < ApplicationRecord
  validates :city, presence: true
  validates :description, presence: true
  validates :kind, presence: true
  validates :consent, presence: { message: "mora biti odobrena" }
  validates :address, presence: { message: "ne smije biti prazna" }, on: [:create, :update]
  validates :email, format: /@/, if: -> { email.present? }

  validate :phone_or_email_present, on: [:create, :update]
  def phone_or_email_present
    if phone.blank? && email.blank?
      errors.add(:base, "Email ili telefon su obavezni")
    end
  end
end
