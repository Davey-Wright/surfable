require 'rails_helper'
require 'support/omniauth_stub'

feature 'delete user', js: true do
  scenario 'user deletes account' do
    create_and_login_user
    visit edit_user_registration_path
    delete_account
  end

  scenario 'user cancels delete confirmation' do
    create_and_login_user
    visit edit_user_registration_path
    click_on('Delete my account')
    prompt = page.driver.browser.switch_to.alert
    expect(prompt.text).to have_content('Are you sure?')
    prompt.dismiss
    expect(page).not_to have_content('Bye! Your account has been successfully cancelled. We hope to see you again soon.')
  end

  scenario 'delete omniauth user registered account' do
    visit new_user_registration_path
    omniauth_stub(provider: :facebook)
    click_on('Sign in with Facebook')
    click_on('Settings')
    delete_account
  end

end

def create_and_login_user
  user = FactoryBot.create(:user)
  login_as(user, scope: :user)
  user
end

def delete_account
  click_on('Delete my account')
  prompt = page.driver.browser.switch_to.alert
  expect(prompt.text).to have_content('Are you sure?')
  prompt.accept
  expect(page).to have_content('Bye! Your account has been successfully cancelled. We hope to see you again soon.')
end
