require 'rails_helper'

feature 'Spot Delete', js: true do

  let(:spot) { FactoryBot.create(:spot, { name: 'Melaka' }) }

  before(:each) do
    login_as(spot.user)
    visit spot_path(spot)
    click_on('Delete')
  end

  context 'logged in user' do
    describe 'deletes existing spot' do
      it {
        click_on('Confirm')
        expect(page).to_not have_content(/melaka/i)
      }
    end

    describe 'cancels delete' do
      it {
        find('a', text: 'Cancel').click
        expect(page).to have_content(/melaka/i)
      }
    end
  end

end
