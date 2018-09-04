class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.first_name = oauth_first_name(auth)
      user.last_name = oauth_last_name(auth)
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def self.oauth_first_name(auth)
    if auth.provider == 'facebook'
      auth.info.name.split(' ').first
    else
      auth.info.first_name
    end
  end

  def self.oauth_last_name(auth)
    if auth.provider == 'facebook'
      auth.info.name.split(' ').last
    else
      auth.info.last_name
    end
  end

end
