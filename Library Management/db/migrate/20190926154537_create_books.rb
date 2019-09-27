class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :isbn
      t.string :authors
      t.string :language
      t.string :edition
      t.string :published_time
      t.string :subject
      t.string :image
      t.string :summary
      t.boolean :is_special
      t.boolean :is_delete
      t.Boolean :borrowed

      t.timestamps
    end
  end
end
