class Book < ApplicationRecord
  # belongs_to :library
  # has_many :book_historyrails g paperclip good good_image
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5 }
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :is_special , presence: false
  validates :is_delete, presence: false
  # validates :borrowed, presence: false
  validates :isbn, uniqueness: true, presence: true
  validates :title, presence: true
  validates :authors, presence: false
  validates :language, presence: false
  validates :edition, presence: false
  validates :published_time, presence: false
  validates :subject, presence: false
  validates :library, presence: false
  # validates :image, presence: false
  validates :summary, presence: false
  validates :nums_total, presence: true
  validates :nums_borrowed, presence:true
end
