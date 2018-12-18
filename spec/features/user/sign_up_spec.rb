require 'rails_helper'
require 'support/omniauth_stub'

feature 'New User registration', js: true do

  before(:each) do
    visit root_path
    click_on('Sign Up')
  end

  describe 'user resets form' do
    it {
      within('#new_user') do
        fill_form
        click_on('Reset')
      end
      expect(page).to have_current_path(root_path)
      expect_user_count_to_be(0)
    }
  end

  describe 'user submits incomplete form' do
    it {
      within('#new_user') do
        click_on('Sign up')
      end
      expect(page).to have_content(/first name can't be blank/i)
      expect(page).to have_content(/last name can't be blank/i)
      expect(page).to have_content(/email can't be blank/i)
      expect(page).to have_content(/email can't be blank/i)
      expect(page).to have_content(/password can't be blank/i)
      expect_user_count_to_be(0)
    }
  end

  describe 'user submits complete form' do
    it {
      within('#new_user') do
        fill_form
        click_on('Sign up')
      end
      expect(page.body).to have_content(/surfable forecast/i)
    }
  end

  describe 'sign up with google' do
    it {
      omniauth_stub(provider: :google_oauth2)
      click_on('Sign up with Google')
      expect(page.body).to have_content(/surfable forecast/i)
    }
  end

  describe 'sign up with facebook' do
    it {
      omniauth_stub(provider: :facebook)
      click_on('Sign up with Facebook')
      expect(page.body).to have_content(/surfable forecast/i)
    }
  end

  describe 'with facebook auth using existing email' do
    it {
      FactoryBot.create(:user, { email: 'saltydog@test.com' })
      omniauth_stub(provider: :facebook)
      click_on('Sign up with Facebook')
      expect(page).to have_content('Email has already been taken')
    }
  end

  def fill_form
    fill_in 'user_first_name', with: 'salty'
    fill_in 'user_last_name', with: 'dog'
    fill_in 'user_email', with: 'saltydog@test.com'
    fill_in 'user_password', with: 'saltysender'
    fill_in 'user_password_confirmation', with: 'saltysender'
  end

  def expect_user_count_to_be(n)
    user = User.all
    expect(user.count).to eq(n)
  end

  def user_sign_up_expectations(page)
    expect(page.body).to have_content(/surfable forecast/i)
  end

end
