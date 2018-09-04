class User < ApplicationRecord
  after_create :send_welcome_message

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  def self.from_omniauth(auth)
    UserAuthentication::Omniauth.call(self, auth)
  end

  def send_welcome_message
    UserMailer.welcome_message(self).deliver
  end

end
