module UserAuthentication
  class Omniauth < ApplicationService
    attr_accessor :auth, :user

    def initialize(user, auth)
      @user = user
      @auth = auth
    end

    def call
      user.where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.first_name = get_first_name(auth)
        user.last_name = get_last_name(auth)
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
      end
    end

    def get_first_name(auth)
      if auth.provider == 'facebook'
        auth.info.name.split.first
      else
        auth.info.first_name
      end
    end

    def get_last_name(auth)
      if auth.provider == 'facebook'
        auth.info.name.split.last
      else
        auth.info.last_name
      end
    end

  end
end
