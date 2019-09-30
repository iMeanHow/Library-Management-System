class Admin < ApplicationRecord
  has_secure_password
  has_many :comments, dependent: :destroy
  validates :title, presence: true,
            length: { minimum: 5 }
  validates :email, uniqueness: true, presence: true
  validates :name, presence: true
end
