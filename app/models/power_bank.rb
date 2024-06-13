class PowerBank < ApplicationRecord
  belongs_to :station, optional: true
  belongs_to :warehouse, optional: true
  belongs_to :user, optional: true
  validates :status, inclusion: { in: %w[available in_use] }
end
