require 'test_helper'

class NotifyerMailerTest < ActionMailer::TestCase
  # test "the truth" do
  #   assert true
  # end

    default from: 'notifications@example.com'

    def welcome_email(student)
      @student=student
      mail(to: @student.email, subject: 'Welcome to iLibrary!')
    end

    def borrow_ready_email(student, book)
      @student=student
      @book=book
      mail(to:@student.email, subject: 'Hi #{@student.name}, #{@book.title} is ready to borrow!')
    end


end
