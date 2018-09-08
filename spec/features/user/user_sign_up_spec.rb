require 'rails_helper'
require 'support/omniauth'

describe 'user sign up', type: :feature do

  context 'submit incomplete form' do
    it 'should display errors' do
      visit new_user_registration_path
      submit_form
      expect(page).to have_content("First name can't be blank")
      expect(page).to have_content("Last name can't be blank")
      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Password can't be blank")
      expect_user_count_to_be(0)
    end
  end

  context 'cancel new registration' do
    it' should redirect to homepage' do
      visit new_user_registration_path
      within('#new_user') do
        fill_sign_up_form
        click_on('Cancel')
      end
      expect(page).to have_current_path(root_path)
      expect_user_count_to_be(0)
    end
  end

  context 'submit complete form' do
    it 'should save user in db and redirect to user dashboard' do
      visit new_user_registration_path
      within('#new_user') do
        fill_sign_up_form
        click_on('Sign up')
      end
      user_sign_up_expectations(page)
    end
  end

  context 'sign up with google' do
    it 'should save user in db and redirect to user dashboard' do
      visit new_user_registration_path
      omniauth_stub(provider: :google_oauth2)
      click_on('Sign in with GoogleOauth2')
      user_sign_up_expectations(page)
    end
  end

  context 'sign up with facebook' do
    it 'should save user in db and redirect to user dashboard' do
      visit new_user_registration_path
      omniauth_stub(provider: :facebook)
      click_on('Sign in with Facebook')
      user_sign_up_expectations(page)
    end
  end

end


describe 'clear sign up form', type: :feature, js: true do
  context 'user fills form and clicks clear' do
    it 'should clear sign up form fields' do
      visit new_user_registration_path
      within('#new_user') do
        fill_sign_up_form
        click_on('Clear')
        expect(find_field('user_first_name').value).to eq('')
      end
    end
  end

end

def fill_sign_up_form
  fill_in 'user_first_name', with: 'salty'
  fill_in 'user_last_name', with: 'dog'
  fill_in 'user_email', with: 'saltydog@test.com'
  fill_in 'user_password', with: 'saltydogtest'
  fill_in 'user_password_confirmation', with: 'saltydogtest'
end

def submit_form
  find(".new_user input[value='Sign up']").click
end

def expect_user_count_to_be(n)
  user = User.all
  expect(user.count).to eq(n)
end

def user_sign_up_expectations(page)
  user = User.first
  expect(user.first_name).to eq('salty')
  expect(user.last_name).to eq('dog')
  expect(user.email).to eq('saltydog@test.com')

  expect(page).to have_current_path(user_path(user))
  expect(page).to have_content("Shwmae #{User.first.first_name}")
end
