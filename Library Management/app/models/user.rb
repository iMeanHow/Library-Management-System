class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :role, presence: true
  validates :library, presence: false
  validates :fine, presence: false
  validates :name, presence: true
  validates :max_borrow, presence: false
  validates :education_level, presence: false
  validates :borrrow_num, presence: false
  # for request for librarian, false is student or complete request, true is requesting for permission
  :librariansrequest
end
