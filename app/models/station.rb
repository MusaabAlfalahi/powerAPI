class Station < ApplicationRecord
  belongs_to :location, optional: true
  belongs_to :warehouse, optional: true
  has_many :power_banks
  validates :status, inclusion: { in: %w[online offline] }
  validates :power_banks, length: { maximum: 10 }
end
