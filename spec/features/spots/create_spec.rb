require 'rails_helper'

feature 'Spot Create', js: true do

  let(:user) { FactoryBot.create(:user) }

  before(:each) do
    login_as(user)
    visit spots_path
    click_on('Add new spot')
  end

  context 'logged in user' do
    describe 'adds new spot' do
      it {
        within '#new_spot' do
          fill_in 'Name', with: 'Hardies'
          find('label', text: 'Beach').click
          find('label', text: 'Point').click
          find('label', text: 'Left').click
          find('label', text: 'Short').click
          find('label', text: 'Crumbling').click
          find('label', text: 'Slow').click
          click_on("Create Spot")
        end
        expect(page).to have_content(/hardies/i)
        expect(page.body).to have_content(/beach/i, /point/i)
        expect(page.body).to have_content(/crumbling/i)
        expect(page.body).to have_content(/short/i)
        expect(page.body).to have_content(/slow/i)
        expect(page.body).to have_content(/left/i)
      }
    end

    describe 'submit incomplete form' do
      it {
        within '#new_spot' do
          click_on("Create Spot")
        end
        expect(page).to have_content(/please review the problems below:/i)
        expect(page).to have_content(/name can't be blank/i)
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
