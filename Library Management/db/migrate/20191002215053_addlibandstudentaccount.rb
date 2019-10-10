class Addlibandstudentaccount < ActiveRecord::Migration[6.0]
  def change
    Library.create name: 'lib1', university: 'NCSU', location: 'loc', max_borrow: '10', overdue_fine: '1'
  end
end
