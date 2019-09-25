class Book < ActiveRecord::Base
  belongs_to Library
  validates :ISBN, presence => true
  validates :Title, presence => true
  validates :Author, presence => true
  validates :Language, presence => true
  validates :Published, presence => true
  validates :Edition, presence => true
  validates :Title, presence => true
  validates :ImageOfTheFrontCoverPath, presence => true
  validates :Subject, presence => true
  validates :Summary, presence => true
  validates :IsSpecialCollectionItem, presence => true
  validates :Count, presence => true
end