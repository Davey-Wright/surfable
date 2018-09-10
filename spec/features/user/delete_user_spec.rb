require 'rails_helper'

feature 'delete user', js: true do

  scenario 'user deletes account' do
    create_and_login_user
    visit edit_user_registration_path
    click_on('Delete my account')
    prompt = page.driver.browser.switch_to.alert
    expect(prompt.text).to have_content('Are you sure?')
    prompt.accept
    expect(page).to have_content('Bye! Your account has been successfully cancelled. We hope to see you again soon.')
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

end

def create_and_login_user
  user = FactoryBot.create(:user)
  login_as(user, scope: :user)
  user
end
