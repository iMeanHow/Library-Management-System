class AddLibraryToHistory < ActiveRecord::Migration[6.0]
  def change
    add_column :book_histories, :library, :string
  end
end
