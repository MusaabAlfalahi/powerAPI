class Station < ApplicationRecord
  belongs_to :location, optional: true
  belongs_to :warehouse, optional: true
  has_many :power_banks, before_add: :power_banks_count_within_limit
  validates :name, presence: true
  validate :power_banks_count_within_limit
  enum status: { online: "offline", offline: "online" }
  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_status
    self.status ||= :online
  end

  def power_banks_count_within_limit
    if power_banks.size > 10
      errors.add(:base, "Power bank limit for this station reached")
    end
  end
end
