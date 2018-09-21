require 'rails_helper'
require 'support/omniauth_stub'

feature 'user sessions' do
  scenario 'user logs in' do
    user = FactoryBot.create(:user)
    login(user)
    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_current_path(user_path(user))
  end

  scenario 'user logs in with facebook' do
    visit new_user_registration_path
    omniauth_stub(provider: :facebook)
    click_on('Sign in with Facebook')
    user = User.first
    expect(page).to have_current_path(user_path(user))
  end

  scenario 'user logs in with google' do
    visit new_user_registration_path
    omniauth_stub(provider: :google_oauth2)
    click_on('Sign in with GoogleOauth2')
    user = User.first
    expect(page).to have_current_path(user_path(user))
  end

  scenario 'user logs out' do
    user = FactoryBot.create(:user)
    login(user)
    click_on('Sign Out')
    expect(page).to have_current_path(root_path)
    expect(page).to have_content('Signed out successfully.')
    expect(page).to have_content('Sign In')
  end

  scenario 'user session timeout' do
    
  end

  scenario 'user tries login with incorrect details' do
    user = FactoryBot.create(:user)
    visit new_user_session_path
    within('#new_user') do
      fill_in 'user_email', with: 'shaka'
      fill_in 'user_password', with: 'wrongpassword'
      click_on('Log in')
    end
    expect(page).to have_content('Invalid Email or password.')
    expect(page).to have_current_path(new_user_session_path)
  end

end

def login(user)
  visit new_user_session_path
  within('#new_user') do
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on('Log in')
  end
end
