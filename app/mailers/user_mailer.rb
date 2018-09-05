class UserMailer < ApplicationMailer
  def sign_up_confirmation(user)
    mail(to: user.email,
         subject: "Welcome to Saltydog!")
  end
end
