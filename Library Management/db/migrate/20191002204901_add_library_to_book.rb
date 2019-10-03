class AddLibraryToBook < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :library, :string
  end
end
