require 'rails_helper'

feature 'Create wind Condition', js: true do

  let(:spot) { FactoryBot.create(:spot) }

  before(:each) do
    login_as(spot.user)
    visit spot_path(spot)
    click_on('Wind')
    click_on('Add new wind conditions')
  end

  context 'logged in user' do
    describe 'adds new wind condition' do
      it {
        within '#new_condition_wind' do
          choose(option: 1)
          find('label', text: 'Onshore').click
          find('label', text: 'Ne').click
          fill_in('condition_wind[speed]', with: 2)
          click_on("Add Conditions")
        end
        expect(page).to have_content(
          /successfully added new wind conditions to #{ spot.name }/i)
      }
    end

    describe 'submit incomplete form' do
      it {
        expect_validations
      }
    end

    describe 'resets form' do
      it {
        within '#new_condition_wind' do
          choose(option: 1)
          click_on("Reset")
        end
        expect_validations
      }
    end


    def expect_validations
      within '#new_condition_wind' do
        click_on("Add Conditions")
      end
      expect(page).to have_content(/please review the problems below:/i)
      expect(page).to have_content(/rating can't be blank/i)
      expect(page).to have_content(/direction can't be blank/i)
      expect(page).to have_content(/speed can't be blank/i)
    end

  end

end
