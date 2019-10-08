class AddUniversityToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :university, :string
  end
end
