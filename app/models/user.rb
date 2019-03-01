class User < ApplicationRecord
  has_many :spots, dependent: :delete_all

  validates :first_name, presence: true
  validates :last_name, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  def remember_me
    true
  end

  def self.from_omniauth(auth)
    UserAuthentication::Omniauth.call(self, auth)
  end

end
