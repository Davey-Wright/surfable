require 'rails_helper'
require 'support/omniauth_stub'

feature 'User views dashboard', js: true do
  let(:user) { FactoryBot.create(:user) }

  before(:each) do
    login_as user
    visit(user_path(user))
    click_on('Settings')
  end

  context 'unsuccessfully' do
    scenario 'when user tries to visit another users dashboard' do
      other_user = FactoryBot.create(:user)
      visit "/users/#{other_user.id}"
      expect(page).to have_content(/the page you were looking for was not found/i)
    end
  end

  context 'successfully' do
    scenario 'when user visits their own dashboard' do
      expect(page).to have_content(/shwmae/i)
    end
  end
end
