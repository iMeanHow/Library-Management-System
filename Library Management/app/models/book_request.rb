class BookRequest < ApplicationRecord
  validates :time, presence: true
  validates :is_delete, exclusion: {in: [true,false]}, presence: true
  validates :is_accomplished, presence: true
  validates :book_title, presence: true
  validates :book_ISBN, presence: true
  validates :student_name, presence: true
  validates :student_email, presence: true
end
