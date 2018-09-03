require 'rails_helper'

describe 'primary navigation links', type: :feature do
  context 'visitor clicks sign up button' do
    it 'should redirect user to sign up page' do
      visit root_path
      click_on('Sign Up')
      expect(page).to have_current_path(new_user_registration_path)
    end
  end
end
