module Users
  class PasswordsController < Devise::PasswordsController
    def new
      self.resource = resource_class.new
      respond_with { |f| f.js { render 'new', layout: false } }
    end

    def create
      self.resource = resource_class.send_reset_password_instructions(resource_params)
      yield resource if block_given?

      if successfully_sent?(resource)
        respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
      else
        respond_with { |f| f.js { render 'new', layout: false } }
      end
    end
  end
end
