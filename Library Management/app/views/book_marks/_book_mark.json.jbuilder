json.extract! book_mark, :id, :book_isbn, :book_title, :student_name, :student_email, :created_at, :updated_at
json.url book_mark_url(book_mark, format: :json)
