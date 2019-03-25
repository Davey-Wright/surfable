require 'rails_helper'
require 'support/omniauth_stub'

feature 'New user registration', js: true do
  before(:each) do
    visit root_path
    click_on('Sign Up')
  end

  context 'unsuccessfull' do
    scenario 'when user resets form' do
      within('#new_user') do
        fill_form('surfable@demo.com')
        click_on('Reset')
      end
      expect(page).to have_current_path(root_path)
    end

    scenario 'when user submits incomplete form' do
      within('#new_user') do
        click_on('Sign up')
      end
      expect(page).to have_content(/first name can't be blank/i)
      expect(page).to have_content(/last name can't be blank/i)
      expect(page).to have_content(/email can't be blank/i)
      expect(page).to have_content(/email can't be blank/i)
      expect(page).to have_content(/password can't be blank/i)
    end

    scenario 'when password is to short' do
      within('#new_user') do
        fill_in 'user_first_name', with: 'salty'
        fill_in 'user_last_name', with: 'dog'
        fill_in 'user_email', with: 'surfable@demo.com'
        fill_in 'user_password', with: 'sasa'
        fill_in 'user_password_confirmation', with: 'sasa'
        click_on('Sign up')
        expect(page).to have_content(/password is too short/i)
      end
    end

    scenario 'users password and password confirmation dont match' do
      within('#new_user') do
        fill_in 'user_first_name', with: 'salty'
        fill_in 'user_last_name', with: 'dog'
        fill_in 'user_email', with: 'surfable@demo.com'
        fill_in 'user_password', with: 'saltysender'
        fill_in 'user_password_confirmation', with: 'invalidconfirmation'
        click_on('Sign up')
        expect(page).to have_content(/password confirmation doesn't match password/i)
      end
    end

    scenario 'when user tries to register with an email that is already registered' do
      email = 'surfable@demo.com'
      FactoryBot.create(:user, email: email)
      within('#new_user') do
        fill_form(email)
        click_on('Sign up')
      end
      page.find(:css, '.user_email .error', text: 'Email has already been taken')
    end

    scenario 'when user tries to register with facebook auth using a registered email' do
      FactoryBot.create(:user, email: 'saltydog@test.com')
      omniauth_stub(provider: :facebook)
      click_on('Sign up with Facebook')
      page.find(:css, '.user_email .error', text: 'Email has already been taken')
    end
  end

  context 'successfully' do
    scenario 'user submits complete form' do
      email = 'saltydog@demo.com'
      within('#new_user') do
        fill_form(email)
        click_on('Sign up')
      end
      expect(page).to have_content(/you have successfully signed up. welcome to surfable!/i)
      delivers_email_to(email)
    end

    scenario 'sign up with facebook' do
      omniauth_stub(provider: :facebook)
      email = omniauth_stub[:info][:email]
      click_on('Sign up with Facebook')
      expect(page).to have_content(/successfully logged in from facebook/i)
      delivers_email_to(email)
    end
  end

  def fill_form(email)
    fill_in 'user_first_name', with: 'salty'
    fill_in 'user_last_name', with: 'dog'
    fill_in 'user_email', with: email
    fill_in 'user_password', with: 'saltysender'
    fill_in 'user_password_confirmation', with: 'saltysender'
  end

  def delivers_email_to(email)
    message = ActionMailer::Base.deliveries.last
    expect(message.to.first).to eq(email)
    expect(message.subject).to eq('Welcome to Surfable!')
  end
end
