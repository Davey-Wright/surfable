require 'rails_helper'
require 'support/omniauth'

describe 'new user registration', type: :feature do
  context 'visitor clicks sign up button' do
    it 'should redirect user to sign up page' do
      visit root_path
      click_on('Sign Up')
      expect(page).to have_current_path(new_user_registration_path)
    end
  end

  context 'visitor submits incomplete registration form' do
    it 'should throw an validation error' do
      visit new_user_registration_path
      submit_form
      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Password can't be blank")
      expect_user_count_to_be(0)
    end
  end

  context 'visitor cancels new registration' do
    it' should clear user registration form' do
      visit new_user_registration_path
      within('#new_user') do
        fill_registration_form
        click_on('Cancel')
      end
      expect(page).to have_current_path(root_path)
      expect_user_count_to_be(0)
    end
  end

  context 'Visitor successfully registers' do
    it 'should save user in db and redirect to user dashboard' do
      visit new_user_registration_path
      within('#new_user') do
        fill_registration_form
        click_on('Sign up')
      end
      user_registration_expectations(page)
    end
  end

  context 'visitor successfully signs up with google' do
    it 'should save user in db and redirect to user dashboard' do
      visit new_user_registration_path
      omniauth_stub(provider: :google_oauth2)
      click_on('Sign in with GoogleOauth2')
      user_registration_expectations(page)
    end
  end

  context 'visitor successfully signs up with facebook' do
    it 'should save user in db and redirect to user dashboard' do
      visit new_user_registration_path
      omniauth_stub(provider: :facebook)
      click_on('Sign in with Facebook')
      user_registration_expectations(page)
    end
  end

end


describe 'user clears registration form', type: :feature, js: true do
  context 'user fill form and clicks clear' do
    it 'should clear registration form fields' do
      visit new_user_registration_path
      within('#new_user') do
        fill_registration_form
        click_on('Clear')
        expect(find_field('user_first_name').value).to eq('')
      end
    end
  end

end


def user_registration_expectations(page)
  user = User.first
  expect(user.first_name).to eq('salty')
  expect(user.last_name).to eq('dog')
  expect(user.email).to eq('saltydog@test.com')

  expect(page).to have_current_path(user_path(user))
  expect(page).to have_content("Shwmae #{User.first.first_name}")
end

def submit_form
  find(".new_user input[value='Sign up']").click
end

def expect_user_count_to_be(n)
  user = User.all
  expect(user.count).to eq(n)
end

def fill_registration_form
  fill_in 'user_first_name', with: 'salty'
  fill_in 'user_last_name', with: 'dog'
  fill_in 'user_email', with: 'saltydog@test.com'
  fill_in 'user_password', with: 'saltydogtest'
  fill_in 'user_password_confirmation', with: 'saltydogtest'
end
