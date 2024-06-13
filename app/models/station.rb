class Station < ApplicationRecord
  belongs_to :location, optional: true
  belongs_to :warehouse, optional: true
  validates :status, inclusion: { in: %w[online offline] }
end
