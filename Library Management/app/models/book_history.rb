class BookHistory < ApplicationRecord
  validates :borrow_time, presence: true
  validates :return_time, presence: false
  validates :overdue_fine, presence: false
  validates :book_title, presence: true
  validates :book_isbn, presence: true
  validates :student_name, presence: true
  validates :student_email, presence: true
  validates :is_returned, presence: false
end
