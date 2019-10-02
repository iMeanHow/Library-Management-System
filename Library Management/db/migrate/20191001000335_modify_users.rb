class ModifyUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.boolean :librariansrequest
    end
  end
end
