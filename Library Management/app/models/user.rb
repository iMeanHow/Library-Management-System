class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :role, presence: true
  validates :library, presence: false
  validates :fine, presence: false
  validates :name, presence: true
  validates :max_borrow, presence: false
  validates :education_level, presence: true
  validates :borrow_num, presence: true
  # for request for librarian, false is student or complete request, true is requesting for permission
  :librariansrequest
end
