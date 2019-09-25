class Librarian < User
  validates :Library, presence: true
end