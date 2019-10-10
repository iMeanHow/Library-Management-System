class LibMailer < ApplicationMailer
  default from: 'iwolflib@gmail.com'

  def send_email(user,book)

    mail(to:user.email, subject: 'Book ready to pick up!')
  end

  def send_failure_email(user,book)
    mail(to:user.email, subject: 'Book request cancelled!')
  end

  def send_borrow_email(user,book)
    mail(to:user.email, subject: 'Book has been borrowed to you!')
  end
end
