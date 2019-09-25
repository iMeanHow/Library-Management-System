class User < ActiveRecord::Base
  validates :Name, presence: true
  validates :Email, presence: true
  validates :Password, presence: true
end