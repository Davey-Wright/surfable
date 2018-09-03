class RegistrationsController < Devise::RegistrationsController
  private
    def sign_up_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

    def after_sign_up_path_for(user)
      user_path(user)
    end

    def after_sign_in_path_for(user)
      user_path(user)
    end
end
