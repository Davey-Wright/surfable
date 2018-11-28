module Users
  class SessionsController < Devise::SessionsController

    def new
      self.resource = resource_class.new(sign_in_params)
      clean_up_passwords(resource)
      yield resource if block_given?
      # respond_with(resource, serialize_options(resource))
      respond_with do |f|
        f.js { render 'new', layout: false }
        serialize_options(resource)
      end
    end

    private

    # params[:user].merge!(remember_me: 1)

    def after_sign_in_path_for(user)
      user_forecast_path(user)
    end
  end
end
