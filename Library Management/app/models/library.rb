class Library < ApplicationRecord
  # has_many :books
  validates :university, presence: true
  validates :name, uniqueness: true, presence: true
  validates :location, presence: true
  validates :max_borrow, presence: true,numericality: { greater_than_or_equal_to: 0 }
  validates :overdue_fine, presence: true,numericality: { greater_than_or_equal_to: 0 }
end
