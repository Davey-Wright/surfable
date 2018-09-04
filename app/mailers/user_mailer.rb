class UserMailer < ApplicationMailer
  def welcome_message(user)
    mail(to: user.email,
         subject: "Welcome to Saltydog!")
  end
end
