class PowerBank < ApplicationRecord
  belongs_to :station, optional: true
  belongs_to :warehouse, optional: true
  belongs_to :user, optional: true
  enum status: { available: "available", in_use: "in_use" }, _default: "available"

  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_status
    self.status ||= :available
  end
end
