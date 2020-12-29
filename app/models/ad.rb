class Ad < ApplicationRecord
  validates :city, presence: true
  validates :description, presence: true
  validates :kind, presence: true
  validates :phone, presence: true
end
