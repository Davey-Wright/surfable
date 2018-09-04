class UserRegistrationMailer < ApplicationMailer
  default from: 'shaka_melaka@gmail.com'

  def new_user
    mail(to: "d-a-v-e-y@hotmail.com",
         subject: "Welcome to Saltydog!")
  end
end
