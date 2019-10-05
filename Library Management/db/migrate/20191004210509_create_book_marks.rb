class CreateBookMarks < ActiveRecord::Migration[6.0]
  def change
    create_table :book_marks do |t|
      t.string :book_isbn
      t.string :book_title
      t.string :student_name
      t.string :student_email

      t.timestamps
    end
  end
end
