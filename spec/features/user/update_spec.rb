require 'rails_helper'
require 'support/omniauth_stub'

feature 'User updates account details', type: :feature, js: true do
  let(:user) { FactoryBot.create(:user) }

  before(:each) do
    login_as user
    visit(user_path(user))
    click_on('Settings')
  end

  context 'unsuccessfully' do
    scenario 'when user cancels form' do
      within('#edit_user') do
        click_link('Cancel')
      end
      expect(page).to have_current_path(user_path(user))
    end

    scenario 'when user submits incomplete form' do
      within('#edit_user') do
        fill_in 'user_first_name', with: ''
        fill_in 'user_last_name', with: ''
        fill_in 'user_email', with: ''
        fill_in 'user_password', with: ''
        fill_in 'user_password_confirmation', with: ''
        fill_in 'user_current_password', with: ''
        click_on('Update Account')
      end
      expect(page).to have_content(/first name can't be blank/i)
      expect(page).to have_content(/last name can't be blank/i)
      expect(page).to have_content(/email can't be blank/i)
      expect(page).to have_content(/current password can't be blank/i)
    end

    scenario 'when new password and new password confirmation dont match' do
      within('#edit_user') do
        fill_in 'user_first_name', with: 'Melaka'
        fill_in 'user_last_name', with: 'Shaka'
        fill_in 'user_email', with: 'surfable@demo.com'
        fill_in 'user_password', with: 'saltysender'
        fill_in 'user_password_confirmation', with: 'invalidconfirmation'
        fill_in 'user_current_password', with: 'saltysender'
        click_on('Update Account')
      end
      expect(page).to have_content(/password confirmation doesn't match password/i)
    end

    scenario 'when new password is to short' do
      within('#edit_user') do
        fill_in 'user_first_name', with: 'Melaka'
        fill_in 'user_last_name', with: 'Shaka'
        fill_in 'user_email', with: 'surfable@demo.com'
        fill_in 'user_password', with: 'sasa'
        fill_in 'user_password_confirmation', with: 'sasa'
        fill_in 'user_current_password', with: 'saltysender'
        click_on('Update Account')
      end
      expect(page).to have_content(/password is too short/i)
    end

    scenario 'user tries to change email to already registered email' do
      other_user = FactoryBot.create(:user, email: 'surf_sender@demo.com')
      fill_form(other_user.email)
      expect(page).to have_content(/email has already been taken/i)
    end

    scenario 'when current password is incorrect' do
      within('#edit_user') do
        fill_in 'user_first_name', with: 'Melaka'
        fill_in 'user_last_name', with: 'Shaka'
        fill_in 'user_email', with: 'surfable@demo.com'
        fill_in 'user_password', with: 'saltysender'
        fill_in 'user_password_confirmation', with: 'saltysender'
        fill_in 'user_current_password', with: 'invalidpassword'
        click_on('Update Account')
        expect(page).to have_content(/current password is invalid/i)
      end
    end
  end

  context 'successfully' do
    scenario 'when user submits valid form' do
      fill_form 'surfable@demo.com'
      expect(page).to have_content(/Your account has been updated successfully/i)
    end
  end

  def fill_form(email)
    within('#edit_user') do
      fill_in 'user_first_name', with: 'salty'
      fill_in 'user_last_name', with: 'dog'
      fill_in 'user_email', with: email
      fill_in 'user_password', with: 'newpassword'
      fill_in 'user_password_confirmation', with: 'newpassword'
      fill_in 'user_current_password', with: 'saltysender'
      click_on('Update Account')
    end
  end
end
