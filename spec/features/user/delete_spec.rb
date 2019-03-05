require 'rails_helper'
require 'support/omniauth_stub'

feature 'User deletes account', js: true do
  let(:user) { FactoryBot.create(:user) }

  before(:each) do
    login_as user
    visit(user_path(user))
    click_on('Settings')
    click_on('Delete my Account')
  end

  context 'unsuccessfully' do
    scenario 'when user cancels delete confirmation' do
      within '.modal_content' do
        click_on('Cancel')
        expect(page).to have_current_path(user_path(user))
      end
    end
  end

  context 'successfully' do
    scenario 'when user clicks confirm' do
      within '.modal_content' do
        click_on('Confirm')
      end
      delivers_email_to(user.email)
      expect(page).to have_current_path(root_path)
    end
  end

  def delivers_email_to(email)
    message = ActionMailer::Base.deliveries.last
    expect(message.to.first).to eq(email)
    expect(message.subject).to eq('Your account was successfully deleted')
  end
end
