class User < ApplicationRecord
  has_many :spots

  validates :first_name, presence: true
  validates :last_name, presence: true

  after_create_commit   :send_sign_up_confirmation
  after_update_commit   :send_update_confirmation
  after_destroy_commit  :send_delete_confirmation


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
