require 'rails_helper'
require 'support/omniauth_stub'

feature 'sign up' do
  scenario 'cancel new registration' do
    visit new_user_registration_path
    within('#new_user') do
      fill_sign_up_form
      click_on('Cancel')
    end
    expect(page).to have_current_path(root_path)
    expect_user_count_to_be(0)
  end

  scenario'submit incomplete form' do
    visit new_user_registration_path
    within('#new_user') do
      click_on('Sign up')
    end
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
    expect_user_count_to_be(0)
  end

  scenario 'submit complete form' do
    visit new_user_registration_path
    within('#new_user') do
      fill_sign_up_form
      click_on('Sign up')
    end
    user_sign_up_expectations(page)
  end

  scenario 'sign up with google' do
    visit new_user_registration_path
    omniauth_stub(provider: :google_oauth2)
    click_on('Sign in with GoogleOauth2')
    user_sign_up_expectations(page)
  end

  scenario 'sign up with facebook' do
    visit new_user_registration_path
    omniauth_stub(provider: :facebook)
    click_on('Sign in with Facebook')
    user_sign_up_expectations(page)
  end

  scenario 'with facebook auth using existing email' do
    FactoryBot.create(:user, {email: 'saltydog@test.com'})
    visit new_user_registration_path
    omniauth_stub(provider: :facebook)
    click_on('Sign in with Facebook')
    expect(page).to have_content('Email has already been taken')
  end

  scenario 'user fills form and clicks clear', js: true do
    visit new_user_registration_path
    within('#new_user') do
      fill_sign_up_form
      click_on('Clear')
      expect(find_field('user_first_name').value).to eq('')
    end
  end

  scenario 'visitor clicks sign up button' do
    visit root_path
    click_on('Sign Up')
    expect(page).to have_current_path(new_user_registration_path)
  end

  def fill_sign_up_form
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
    user = User.first
    expect(user.first_name).to eq('salty')
    expect(user.last_name).to eq('dog')
    expect(user.email).to eq('saltydog@test.com')

    expect(page).to have_current_path(user_path(user))
    expect(page).to have_content("Shwmae #{User.first.first_name}")
  end

end
