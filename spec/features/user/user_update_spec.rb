require 'rails_helper'

describe 'update user account', type: :feature do
  context 'user has registered with OAuth and is on dashboard' do
    it 'should not display edit button' do
      
    end
  end

  context 'user is on dashboard and clicks edit button' do
    it 'should redirect to user update page and display prefilled form' do
      user = create_and_login_user
      visit user_path(user)
      click_on('Edit')
      expect(page).to have_current_path(edit_user_registration_path(user))
    end
  end

  context 'user cancels update' do
    it 'should redirect to user dashboard and display old user information' do
      user = create_and_login_user
      visit edit_user_registration_path(user)
      click_on('Go back')
      expect(page).to have_current_path(user_path(user))
      expect(page).to have_content(user.first_name, user.last_name)
    end
  end

  context 'user submits incomplete update form' do
    it 'should display errors' do
      user = create_and_login_user
      visit edit_user_registration_path(user)
      within('#edit_user') do
        fill_in 'user_first_name', with: ''
        fill_in 'user_last_name', with: ''
        fill_in 'user_email', with: ''
        fill_in 'user_current_password', with: ''
        click_on('Update')
      end
      expect(page).to have_content("First name can't be blank")
      expect(page).to have_content("Last name can't be blank")
      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Current password can't be blank")
    end
  end

  context 'user updates account details' do
    it 'should confirm user updated account' do
      user = create_and_login_user
      visit edit_user_registration_path(user)
      within('#edit_user') do
        fill_in 'user_first_name', with: 'salty'
        fill_in 'user_last_name', with: 'dog'
        fill_in 'user_email', with: 'saltydog@test.com'
        fill_in 'user_current_password', with: 'saltysender'
        click_on('Update')
      end
      expect(page).to have_content('Your account has been updated successfully.')
      expect(page).to have_current_path(user_path(user))
    end
  end

end

def create_and_login_user
  user = FactoryBot.create(:user)
  login_as(user, scope: :user)
  user
end
