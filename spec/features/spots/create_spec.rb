require 'rails_helper'

feature 'create' do
  scenario 'user creates account' do
    user = create_and_login_user
  end

end

def create_and_login_user
end
