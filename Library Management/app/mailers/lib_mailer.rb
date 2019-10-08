class LibMailer < ApplicationMailer
  default from: 'iwolflib@gmail.com'

  def send_email(user,book)

    mail(to:user.email, subject: 'Successful book request ')
  end
end
