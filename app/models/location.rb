class Location < ApplicationRecord
  has_many :stations

  validates :name, presence: true
end
