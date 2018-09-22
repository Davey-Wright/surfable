class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  after_commit :send_sign_up_confirmation, on: :create
  after_commit :send_update_confirmation, on: :update
  after_commit :send_delete_confirmation, on: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  def self.from_omniauth(auth)
    UserAuthentication::Omniauth.call(self, auth)
  end

  def send_sign_up_confirmation
    UserMailer.sign_up_confirmation(self).deliver
  end

  def send_update_confirmation
    UserMailer.update_confirmation(self).deliver
  end

  def send_delete_confirmation
    UserMailer.delete_confirmation(self).deliver
  end

end
