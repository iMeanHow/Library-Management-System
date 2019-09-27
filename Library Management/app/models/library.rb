class Library < ApplicationRecord
  has_many :books
  validates :university, presence: true
  validates :name, uniqueness: true, presence: true
  validates :location, presence: true
  validates :max_borrow, presence: true
  validates :overdue_fine, presence: true
end
