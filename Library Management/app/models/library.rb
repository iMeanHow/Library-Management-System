class Library < ActiveRecord::Base
  has_many :books

  validates :Name, presence: true
  validates :University, presence: true
  validates :Location, presence: true
  validates :MaximumNumberOfDaysABookCanBeBorrowed, presence: true
  validates :OverdueFines, presence: true
end