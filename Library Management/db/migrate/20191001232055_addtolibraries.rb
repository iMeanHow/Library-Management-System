class Addtolibraries < ActiveRecord::Migration[6.0]
  def change
    change_table :libraries do |t|

      t.string :university
      end
  end
end
