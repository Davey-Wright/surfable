require 'rails_helper'
require 'support/omniauth_stub'

feature 'User Sessions', js: true do

  let(:user) { FactoryBot.create(:user) }

  before(:each) do
    visit root_path
    click_on('Log In')
  end

  describe 'user logs in' do
    it {
      within('#new_user') do
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
        click_on('Log in')
      end
      expect(page).to have_current_path(forecast_path)
      expect(page).to have_content('Signed in successfully.')
    }
  end

  describe 'user logs in with facebook' do
    it {
      omniauth_stub(provider: :facebook)
      click_on('Log in with Facebook')
      expect(page).to have_content('Successfully logged in from Facebook account.')
    }
  end

  describe 'user logs in with google' do
    it {
      omniauth_stub(provider: :google_oauth2)
      click_on('Log in with Google')
      expect(page).to have_content('Successfully logged in from Google account.')
    }
  end

  describe 'user logs out' do
    it {
      within('#new_user') do
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
        click_on('Log in')
      end
      visit forecast_path
      save_and_open_page
      click_on('Sign Out')
      expect(page).to have_current_path(root_path)
      expect(page).to have_content('Signed out successfully.')
      expect(page).to have_content('Log In')
    }
  end

  describe 'user tries login with incorrect details' do
    it {
      user = FactoryBot.create(:user)
      visit new_user_session_path
      within('#new_user') do
        fill_in 'user_email', with: 'shaka'
        fill_in 'user_password', with: 'wrongpassword'
        click_on('Log in')
      end
      expect(page).to have_content('Invalid Email or password.')
      expect(page).to have_current_path(new_user_session_path)
    }
  end

  def login(u)
    within('#new_user') do
      fill_in 'user_email', with: u.email
      fill_in 'user_password', with: u.password
      click_on('Log in')
    end
  end

end
