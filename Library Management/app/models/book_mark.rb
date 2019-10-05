class BookMark < ApplicationRecord
  validates :book_title, presence: true
  validates :book_isbn, presence: true
  validates :student_name, presence: true
  validates :student_email, presence: true
end
