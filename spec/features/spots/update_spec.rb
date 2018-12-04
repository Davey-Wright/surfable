require 'rails_helper'

feature 'Spot Update', js: true do

  let(:spot) { FactoryBot.create(:spot, {
    name: 'shaka',
    wave_break_type: ['beach'],
    wave_shape: ['crumbling', 'steep'],
    wave_direction: ['left', 'right'],
    wave_length: ['short', 'average'],
    wave_speed: ['slow', 'average'] }
    ) }

  before(:each) do
    login_as(spot.user)
    visit spot_path(spot)
    click_on('Edit')
  end

  context 'logged in user' do
    describe 'adds new spot' do
      it {
        within 'form' do
          fill_in 'Name', with: 'Hardies'
          find('label', text: 'Beach').click
          find('label', text: 'Crumbling').click
          find('label', text: 'Left').click
          find('label', text: 'Long').click
          find('label', text: 'Fast').click
          click_on("Update Spot")
        end
        expect(page).to have_content(/hardies/i)
        expect(page.body).to_not have_content(/beach/i)
        expect(page.body).to_not have_content(/crumbling/i)
        expect(page.body).to_not have_content(/left/i)
        expect(page.body).to have_content(/fast/i)
        expect(page.body).to have_content(/long/i)
      }
    end

    describe 'submit incomplete form' do
      it {
        within 'form' do
          fill_in 'Name', with: ''
          click_on("Update Spot")
        end
        expect(page).to have_content(/please review the problems below:/i)
        expect(page).to have_content(/name can't be blank/i)
      }
    end

    describe 'resets form' do
      it {
        within 'form' do
          fill_in 'Name', with: 'Reset this Name'
          click_on("Reset")
        end
        expect(page).to_not have_content(/'reset this name'/i)
      }
    end

    describe 'cannot find spot' do
      it {
        within 'form' do
          fill_in 'Name', with: 'Reset this Name'
          click_on("Reset")
        end
        expect(page).to_not have_content(/'reset this name'/i)
      }
    end
  end

end
