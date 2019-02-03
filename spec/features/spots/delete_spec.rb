require 'rails_helper'

# Test that
  # Delete button reveals confirmation
  # Spot is deleted on confirmation
  # Returns to spot page on confirmation cancel
  # After spot destroy redirect to spots index

feature 'User deletes a spot', js: true do
  let(:spot) { FactoryBot.create(:spot, name: 'Melaka') }

  before(:each) do
    login_as(spot.user)
    visit spot_path(spot)
    within('#spot-show') { click_on('Delete') }
  end

  context 'logged in user' do
    scenario 'deletes existing spot' do
      click_on('Confirm')
      expect(page).to have_current_path(spots_path)
      expect(page).to_not have_content(/melaka/i)
    end

    scenario 'cancels delete' do
      click_on('Cancel')
      expect(page).to have_current_path(spot_path(spot))
      expect(page).to have_content(/melaka/i)
    end
  end
end
