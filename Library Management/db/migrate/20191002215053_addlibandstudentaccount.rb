class Addlibandstudentaccount < ActiveRecord::Migration[6.0]
  def change
    Library.create name: 'lib1', university: 'uni', location: 'loc', max_borrow: '10', overdue_fine: '1'
    User.create name: 'lib', email: 'lib@a.com', role: 'librarian', password: '1', librariansrequest: 'false', library: 'lib1'
    User.create name: 'std', email: 'std@a.com', role: 'student', password: '1', librariansrequest: 'false'
  end
end
