class Student < User
  validates :EducationalLevel, presence: true
  validates :University, presence: true
  validates :MaximumNumberOfBooks, presence: true
end