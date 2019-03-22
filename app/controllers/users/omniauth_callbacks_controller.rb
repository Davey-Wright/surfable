module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    respond_to :html, :js

    def facebook
      omniauth_callback('Facebook')
    end

    def omniauth_callback(provider)
      auth = request.env['omniauth.auth']
      @user = set_user(auth)

      if @user.nil?
        @user = create_user(auth)
        if @user.persisted?
          set_flash_message(:notice, :success, kind: provider) if is_navigational_format?
          sign_in_and_redirect @user, event: :authentication
          UserMailer.sign_up_confirmation(@user).deliver_later
        else
          session["devise.#{provider.downcase}_data"] = request.env['omniauth.auth']
          notices = flash[:notice].to_a.concat resource.errors.full_messages
          notices.each { |n| flash[:notice] = n }
          redirect_to root_path
        end
      else
        set_flash_message(:notice, :success, kind: provider) if is_navigational_format?
        sign_in_and_redirect @user, event: :authentication
      end
    end

    def failure
      redirect_to root_path
    end

    private

    def set_user(auth)
      User.where(provider: auth.provider, uid: auth.uid).first
    end

    def create_user(auth)
      User.create(
        provider: auth.provider,
        uid: auth.uid,
        first_name: auth.info.name.split.first,
        last_name: auth.info.last_name,
        email: auth.info.email,
        password: Devise.friendly_token[0, 20]
      )
    end
  end
end
