module Users
  class RegistrationsController < Devise::RegistrationsController
    respond_to :html, :js

    def send_update_confirmation
      UserMailer.update_confirmation(self).deliver
    end

    def send_delete_confirmation
      UserMailer.delete_confirmation(self).deliver
    end

    def new
      build_resource
      yield resource if block_given?
      respond_with { |f| f.js { render 'new', layout: false } }
    end

    def create
      build_resource(sign_up_params)
      resource.save
      yield resource if block_given?
      if resource.persisted?
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          sign_in_and_redirect @user, event: :authentication
          UserMailer.sign_up_confirmation(@user).deliver_later
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with { |f| f.js { render 'new', layout: false } }
      end
    end

    def edit
      respond_with { |f| f.js { render 'edit', layout: false } }
    end

    def update
      self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
      prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

      resource_updated = update_resource(resource, account_update_params)
      yield resource if block_given?
      if resource_updated
        if is_flashing_format?
          flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
            :update_needs_confirmation : :updated
          set_flash_message :notice, flash_key
        end
        bypass_sign_in resource, scope: resource_name
        after_update_path_for(@user)
      else
        clean_up_passwords resource
        set_minimum_password_length
        # respond_with resource
        respond_with { |f| f.js { render 'edit', layout: false } }
      end
    end

    private

      def sign_up_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
      end

      def account_update_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
      end

      def after_sign_up_path_for(resource)
        return redirect_to forecast_path if is_navigational_format?
      end

      def after_update_path_for(user)
        return redirect_to user_path(user) if is_navigational_format?
      end
  end
end
