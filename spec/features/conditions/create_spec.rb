require 'rails_helper'

feature 'Condition Create', js: true do

  let(:spot) { FactoryBot.create(:spot) }

  before(:each) do
    login_as(spot.user)
    visit spot_path(spot)
    click_on('Add new condition')
  end

  context 'logged in user' do
    describe 'adds new condition' do
      it {
        within '#new_condition' do
          fill_in 'Name', with: 'Hardies'
          find('label', text: 'Beach').click
          find('label', text: 'Point').click
          find('label', text: 'Left').click
          find('label', text: 'Short').click
          find('label', text: 'Crumbling').click
          find('label', text: 'Slow').click
          click_on("Create Condition")
        end
        # expect(page.body).to have_content(/beach/i, /point/i)
      }
    end

    describe 'submit incomplete form' do
      it {
        within '#new_spot' do
          click_on("Create Condition")
        end
        expect(page).to have_content(/please review the problems below:/i)
        expect(page).to have_content(/condition validations here/i)
      }
    end

    describe 'resets form' do
      it {
        within '#new_spot' do
          fill_in 'Name', with: 'Reset this Name'
          click_on("Reset")
        end
        expect(page).to_not have_content(/reset this name/i)
      }
    end
  end

end
