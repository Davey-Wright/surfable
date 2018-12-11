require 'rails_helper'

feature 'Create Swell Condition', js: true do

  let(:spot) { FactoryBot.create(:spot) }

  before(:each) do
    login_as(spot.user)
    visit spot_path(spot)
    click_on('Swell')
    click_on('Add new swell conditions')
  end

  context 'logged in user' do
    describe 'adds new swell condition' do
      it {
        within '#new_condition_swell' do
          choose(option: 1)
          fill_in 'Min Height', with: 2
          fill_in 'Max Height', with: 10
          fill_in 'Min Period', with: 10
          find('label', text: 'Nw').click
          click_on("Add Conditions")
        end
        expect(page).to have_content(
          /successfully added new swell conditions to #{ spot.name }/i)
      }
    end

    describe 'submit incomplete form' do
      it {
        within '#new_condition_swell' do
          click_on("Add Conditions")
        end
        expect(page).to have_content(/please review the problems below:/i)
        expect(page).to have_content(/rating can't be blank/i)
        expect(page).to have_content(/min height can't be blank/i)
        expect(page).to have_content(/min period can't be blank/i)
      }
    end

    describe 'resets form' do
      it {
        within '#new_condition_swell' do
          fill_in 'Min Height', with: 'dummy data'
          click_on("Reset")
        end
        expect(page).to_not have_content('dummy data')
      }
    end
  end

end
