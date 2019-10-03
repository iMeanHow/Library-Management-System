class Changebookscolumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :books, :authors, :author
  end
end
