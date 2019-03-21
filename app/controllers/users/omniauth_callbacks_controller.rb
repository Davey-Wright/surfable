module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    respond_to :html, :js

    def facebook
      omniauth_callback('Facebook')
    end

    def omniauth_callback(provider)
      @user = User.from_omniauth(request.env['omniauth.auth'])
      if @user.persisted?
        set_flash_message(:notice, :success, kind: provider) if is_navigational_format?
        sign_in_and_redirect @user, event: :authentication
        # UserMailer.sign_up_confirmation(@user).deliver_later
      else
        session["devise.#{provider.downcase}_data"] = request.env['omniauth.auth']
        notices = flash[:notice].to_a.concat resource.errors.full_messages
        notices.each { |n| flash[:notice] = n }
        redirect_to root_path
      end
    end

    def failure
      redirect_to root_path
    end
  end
end
