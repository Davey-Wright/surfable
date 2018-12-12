require 'rails_helper'

feature 'Create Tide Condition', js: true do

  let(:spot) { FactoryBot.create(:spot) }

  before(:each) do
    login_as(spot.user)
    visit spot_path(spot)
    click_on('Tide')
    click_on('Add new tide conditions')
  end

  context 'logged in user' do
    describe 'adds new tide condition' do
      it {
        within '#new_condition_tide' do
          choose(option: 1)
          within '.condition_tide_rising' do
            find('label', text: 'Low').click
            find('label', text: 'Mid').click
          end
          within '.condition_tide_dropping' do
            find('label', text: 'Low').click
            find('label', text: 'High').click
          end
          find('label', text: 8).click
          click_on("Add Conditions")
        end
        expect(page).to have_content(
          /successfully added new tide conditions to #{ spot.name }/i)
      }
    end

    describe 'submit incomplete form' do
      it {
        expect_validations
      }
    end

    describe 'resets form' do
      it {
        within '#new_condition_tide' do
          choose(option: 1)
          click_on("Reset")
        end
        expect_validations
      }
    end


    def expect_validations
      within '#new_condition_tide' do
        click_on("Add Conditions")
      end
      expect(page).to have_content(/please review the problems below:/i)
      expect(page).to have_content(/rating can't be blank/i)
      expect(page).to have_content(/rising tide times can't be blank/i)
      expect(page).to have_content(/dropping tide times can't be blank/i)
    end

  end

end
