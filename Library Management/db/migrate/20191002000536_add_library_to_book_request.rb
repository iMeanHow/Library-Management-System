class AddLibraryToBookRequest < ActiveRecord::Migration[6.0]
  def change
    add_column :book_requests, :library, :string
  end
end
