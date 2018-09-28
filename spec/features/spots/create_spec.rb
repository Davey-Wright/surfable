require 'rails_helper'

feature 'Create Spot' do
  scenario 'visitor tries to visit spots' do
    visit user_spots_path
    expect(page).to have_current_path(new_user_session_path)
    expect(page).to have_content('Please login to continue')
  end

  scenario 'visitor tries to visit create spot' do
    visit user_new_spot_path
    expect(page).to have_current_path(new_user_session_path)
    expect(page).to have_content('Please login to continue')
  end

  scenario 'user visits new spot form' do
    user = create_and_login_user
    expect(page).to have_content('Create a new spot')
  end

  scenario 'user submits incomplete spot form' do
    user = create_and_login_user
    click_on('Create!')
    expect(page).to have_content('Please fill in the required fields')
  end

  scenario 'user cancels new spot form' do

  end

  scenario 'user creates new spot' do

  end

  def create_and_login_user
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)
    visit new_user_spot_path(user)
    user
  end
end
