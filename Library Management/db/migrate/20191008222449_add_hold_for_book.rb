class AddHoldForBook < ActiveRecord::Migration[6.0]
  def change
    add_column :book_requests, :is_hold_request, :boolean
  end
end
