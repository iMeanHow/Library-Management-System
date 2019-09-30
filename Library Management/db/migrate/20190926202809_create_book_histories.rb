class CreateBookHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :book_histories do |t|
      t.string :book_isbn
      t.boolean :is_returned
      t.string :book_title
      t.string :student_name
      t.string :student_email
      t.time :borrow_time
      t.time :return_time
      t.timestamps
    end
  end
end
