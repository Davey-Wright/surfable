require 'rails_helper'
require 'support/omniauth_stub'

feature 'User logs in', js: true do
  let(:user) { FactoryBot.create(:user) }

  before(:each) do
    visit root_path
    click_on('Log In')
  end

  context 'unsuccessfully' do
    scenario 'user tries login with incorrect details' do
      within('#new_user') do
        fill_in 'user_email', with: 'shaka'
        fill_in 'user_password', with: 'wrongpassword'
        click_on('Log in')
      end
      expect(page).to have_content('Invalid Email or Password.')
      expect(page).to have_current_path(root_path)
    end
    
    scenario 'user forgets password' do
      pending
    end
  end

  context 'successfully' do
    scenario 'user enters correct account details' do
      within('#new_user') do
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
        click_on('Log in')
      end
      assert_text('Signed in successfully.')
      assert page.has_current_path?(forecast_path)
    end

    scenario 'when using facebook login' do
      omniauth_stub(provider: :facebook)
      click_on('Log in with Facebook')
      expect(page).to have_content('Successfully logged in from Facebook.')
    end

    scenario 'user logs out' do
      within('#new_user') do
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
        click_on('Log in')
      end
      assert page.has_current_path?(forecast_path)

      click_on('Sign Out')
      expect(page).to have_current_path(root_path)
      expect(page).to have_content('Signed out successfully.')
      expect(page).to have_content('Log In')
    end
  end
end
