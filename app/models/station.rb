class Station < ApplicationRecord
  belongs_to :location, optional: true
  belongs_to :warehouse, optional: true
  has_many :power_banks
  validates :power_banks, length: { maximum: 10 }
  enum status: { online: "offline", offline: "online" }, _default: "online"

  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_status
    self.status ||= :available
  end
end
