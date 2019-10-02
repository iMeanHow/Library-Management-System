class AddToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.string :education_level
      t.integer :borrow_num
    end
  end
end
