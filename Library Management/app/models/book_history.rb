class BookHistory < ApplicationRecord
  validates :time, presence: true
  # validates :overdue_fine, presence: true
  validates :book_title, presence: true
  validates :book_ISBN, presence: true
  validates :student_name, presence: true
  validates :student_email, presence: true
  validates :is_returned, exclusion: { in: [true, false] }, presence: true
end
