class Warehouse < ApplicationRecord
  has_many :stations
  has_many :power_banks

  validates :name, presence: true
end
