class BookRequest < ApplicationRecord
  # validates :time, presence: false

  validates :book_title, presence: true
  validates :book_isbn, presence: true
  validates :student_name, presence: true
  validates :student_email, presence: true
  validates :is_delete, presence: false
  validates :is_accomplished, presence: false
  validates :is_hold_request, presence: false
end
