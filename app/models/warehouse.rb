class Warehouse < ApplicationRecord
  has_many :stations, optional: true
end
