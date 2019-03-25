module Users
  class SessionsController < Devise::SessionsController
    def new
      self.resource = resource_class.new(sign_in_params)
      clean_up_passwords(resource)
      yield resource if block_given?
      # respond_with(resource, serialize_options(resource))
      respond_with do |f|
        f.js { render 'new', layout: false }
      end
    end

    private

    def after_sign_in_path_for(resource)
      forecast_path
    end

    def after_sign_out_path_for(resource)
      root_path
    end
  end
end
