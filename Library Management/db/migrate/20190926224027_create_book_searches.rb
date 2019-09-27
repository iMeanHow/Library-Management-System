class CreateBookSearches < ActiveRecord::Migration[6.0]
  def change
    create_table :book_searches do |t|

      t.timestamps
    end
  end
end
