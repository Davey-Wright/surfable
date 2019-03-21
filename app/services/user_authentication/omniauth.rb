module UserAuthentication
  class Omniauth < ApplicationService
    attr_accessor :auth, :user

    def initialize(user, auth)
      @user = user
      @auth = auth
    end

    def call
      user.where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.first_name = auth.info.name.split.first
        user.last_name = auth.info.last_name
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
      end
    end
  end
end
