class UserMailer < ApplicationMailer
  def sign_up_confirmation(user)
    @user = user
    mail(to: user.email,
         subject: 'Welcome to Saltydog!')
  end

  def update_confirmation(user)
    @user = user
    mail(to: user.email,
        subject: 'Your account settings have been successfully updated')
  end

  def delete_confirmation(user)
    @user = user
    mail(to: user.email,
        subject: 'Your account has been successfully deleted')
  end
end
