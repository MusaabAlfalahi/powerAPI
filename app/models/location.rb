class Location < ApplicationRecord
  has_many :stations, optional: true
end
