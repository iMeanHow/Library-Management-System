class Addadmincount < ActiveRecord::Migration[6.0]
  def change
    # populate the table
    User.create name: 'admin', email: 'admin@library.com', role: 'admin', password:'123', librariansrequest:'false'
  end
end
