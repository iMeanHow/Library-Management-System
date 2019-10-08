class AddNumsRequestToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :nums_request, :integer
  end
end
