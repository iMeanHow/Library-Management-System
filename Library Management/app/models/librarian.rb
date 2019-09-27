class Librarian < ApplicationRecord
  belongs_to :library
  has_secure_password

  validates :email, uniqueness: true, presence: true
  validates :name, presence: true
end
