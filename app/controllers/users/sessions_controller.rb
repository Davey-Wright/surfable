module Users
  class SessionsController < Devise::SessionsController
    def create
      params[:user].merge!(remember_me: 1)
      super
    end

    private

    def after_sign_in_path_for(user)
      user_path(user)
    end
  end
end
