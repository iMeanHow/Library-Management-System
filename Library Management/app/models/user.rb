class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :role, presence: true
  validates :library, presence: false
  validates :fine, presence: false
  validates :name, presence: true
end
