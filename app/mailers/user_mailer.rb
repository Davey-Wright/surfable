class UserMailer < ApplicationMailer
  def sign_up_confirmation(user)
    @user = user
    mail(to: user.email,
         subject: 'Welcome to Surfable!')
  end

  def update_confirmation(user)
    @user = user
    mail(to: user.email,
        subject: 'Your account settings were successfully updated')
  end

  def delete_confirmation(user)
    @user = user
    mail(to: user.email,
        subject: 'Your account was successfully deleted')
  end
end
