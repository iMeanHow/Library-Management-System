# Version 2.0


===================================================================

All things required have been down! Plus 'No student/librarian should access any private content.'

=================================================================

For test the functions:

* Admin email: admin@library.com   password: 123

* Sign up to be a librarian/student, choose any university does not matter for create librarian

* Librarian created by users need approve from admin, librarian created by admin does not need approment

* Librarian must choose library(click the choice in the dropbox) after approved or created by admin

* Self Management & show all users(for admin) & show overdue(for libarian) are all in User Management & Overdue Management

* Book search（fuzzy search supported) are in BookList link

* View all books and show book in BookList link

* Borrow / Request / Mark / Unmark books in book show page

* Show marked book in Book Mark link

* Approve librarian in View Librarian Request(for admin)

* Approve / Deny / Cancel special book request in View Special Book Request

* View / cancel hold request in View Hold Request

* Return Book in Book Return Management

* View / Create / Destroy Libarry in View Libraries

====================================================================

For edge situations:

* We set a is_delete attributes for books, so book does never really destroy

* Delete book would set is_delete=true, and cannot proceed any new action(show borrow mark...), but transactions existed would not be bothered

* Delete user will delete all transactions he made(mark, request, borrow..) and if there are books not returned, the system will modify the new number of the book 

* Delete library would delete all book related to it

* Delete book would delete all requests and borrows related to it

==========================================================================

* We have test through Book Mark Model and its controller

* Overdue Fine is set for per day

*Borrow limitation is 2 for undergraduate, 4 for master and 6 for phd

* Email notification is activated for borrow/hold request/cancel request/deny request

=====================================================================
 
 
 Any questions you have please contact mliu25@ncsu.edu, we are happy to help!

