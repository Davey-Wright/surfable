class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  after_create :send_sign_up_confirmation

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  def self.from_omniauth(auth)
    UserAuthentication::Omniauth.call(self, auth)
  end

  def send_sign_up_confirmation
    UserMailer.sign_up_confirmation(self).deliver
  end

end
