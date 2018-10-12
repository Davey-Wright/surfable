module Users
  class RegistrationsController < Devise::RegistrationsController
    private
      def sign_up_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
      end

      def account_update_params
        params.require(:user).permit(:first_name, :last_name, :email, :current_password)
      end

      def after_sign_up_path_for(user)
        user_path(user)
      end

      def after_update_path_for(user)
        user_path(user)
      end
  end
end
