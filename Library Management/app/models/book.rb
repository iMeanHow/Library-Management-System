class Book < ApplicationRecord
  # belongs_to :library
  # has_many :book_history
  validates :is_special , presence: false
  validates :is_delete, presence: false
  validates :borrowed, presence: false
  validates :isbn, uniqueness: true, presence: false
  validates :title, presence: false
  validates :authors, presence: false
  validates :language, presence: false
  validates :edition, presence: false
  validates :published_time, presence: false
  validates :subject, presence: false
  validates :image, presence: false
  validates :summary, presence: false
end
