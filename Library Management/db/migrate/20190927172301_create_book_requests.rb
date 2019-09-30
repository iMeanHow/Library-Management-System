class CreateBookRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :book_requests do |t|
      t.string :book_isbn
      t.boolean :is_delete
      t.boolean :is_accomplished
      t.string :book_title
      t.string :student_name
      t.string :student_email
      t.timestamps
    end
  end
end
