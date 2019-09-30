class CreateAdmins < ActiveRecord::Migration[6.0]
  def change
    create_table :admins do |t|
      t.datetime :time
      t.string :book_title
      t.timestamps
    end
  end
end
