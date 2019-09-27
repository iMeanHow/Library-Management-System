class CreateBookHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :book_histories do |t|

      t.timestamps
    end
  end
end
