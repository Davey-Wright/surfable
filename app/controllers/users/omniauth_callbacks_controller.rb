module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      omniauth_callback('Facebook')
    end

    def google_oauth2
      omniauth_callback('Google')
    end

    def omniauth_callback(provider)
      @user = User.from_omniauth(request.env['omniauth.auth'])
      if @user.persisted?
        after_sign_in_path_for(@user)
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: provider) if is_navigational_format?
      else
        session["devise.#{provider.downcase}_data"] = request.env['omniauth.auth']
        redirect_to new_user_registration_path
        notices = flash[:notice].to_a.concat resource.errors.full_messages
        notices.each { |n| flash[:notice] = n }
      end
    end

    def failure
      redirect_to root_path
    end

    def after_sign_in_path_for(user)
      user_path(user)
    end
  end
end
