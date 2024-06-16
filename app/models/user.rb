class User < ApplicationRecord
  has_secure_password
  has_many :power_banks

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true

  enum isAdmin: { user: 0, admin: 1 }

  def admin?
    isAdmin == "admin"
  end
end
