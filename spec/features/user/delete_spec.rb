require 'rails_helper'
require 'support/omniauth_stub'

feature 'User tries deleting account', js: true do
  # scenario 'user deletes account' do
  #   user = create_and_login_user
  #   click_on_delete_my_account(user)
  #   confirm_password(user.password)
  #   delete_user_expectations
  # end
  #
  # scenario 'user cancels delete confirmation' do
  #   user = create_and_login_user
  #   click_on_delete_my_account(user)
  #   click_on('Cancel')
  #   expect(page).to have_current_path(user_path(user))
  #   expect(User.count).to eq(1)
  # end
  #
  # scenario 'user enters wrong password' do
  #   user = create_and_login_user
  #   click_on_delete_my_account(user)
  #   confirm_password('wrongpassword')
  #   expect(page).to have_current_path(user_confirm_destroy_path(user))
  #   expect(page).to have_content('Your password is invalid')
  # end

  scenario 'delete omniauth user registered account' do
    user = sign_in_OAuth_user(:facebook)
    click_on_delete_my_account(user)
    confirmation_code = find('#confirmation_code').text
    within('#user_confirm_code') do
      expect(find_field('confirmation_code_value').value).to eq('')
      fill_in 'confirmation_code_value', with: confirmation_code
      click_on('Delete')
    end
    delete_user_expectations
  end

  # scenario 'omniauth user enters wrong confirmation code' do
  #   user = sign_in_OAuth_user(:facebook)
  # end

end

def create_and_login_user
  user = FactoryBot.create(:user)
  login_as(user, scope: :user)
  click_on('Settings')
  user
end

def click_on_delete_my_account(user)
  click_on('Delete my account')
  expect(page).to have_current_path(user_confirm_destroy_path(user))
end

def confirm_password(password)
  within('#user_password_confirmation') do
    expect(find_field('user_current_password').value).to eq('')
    fill_in 'user_current_password', with: password
    click_on('Delete')
  end
end

def sign_in_OAuth_user(provider)
  visit new_user_registration_path
  omniauth_stub(provider: provider)
  click_on('Sign in with Facebook')
  click_on('Settings')
  user = User.first
end

def delete_user_expectations
  expect(page).to have_current_path(root_path)
  expect(page).to have_content('Your account has been deleted successfully')
  expect(User.count).to eq(0)
end
