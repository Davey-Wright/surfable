require 'rails_helper'

feature 'Swell Condition CRUD', js: true do
  let(:swell) { FactoryBot.create(:swell_conditions) }

  before(:each) do
    login_as(swell.spot.user)
    visit spot_path(swell.spot)
    click_on('Swell')
  end

  context 'logged in user' do

    context 'viewing conditions' do
      describe 'with existing conditions' do
        it {
          expect(page).to have_link('Add new conditions')
          expect(page).to have_link('Delete conditions')
          expect(page.body).to have_content(swell.rating)
          expect(page.body).to have_content(swell.min_period)
          expect(page.body).to have_content(swell.min_height)
        }
      end

      describe 'with no existing conditions' do
        it {
          swell.destroy
          visit spot_path(swell.spot)
          click_on('Swell')
          expect(page).to have_link('Add new conditions')
          expect(page).to_not have_link('Delete conditions')
          expect(page.body).to_not have_content(swell.rating)
          expect(page.body).to_not have_content(swell.min_period)
          expect(page.body).to_not have_content(swell.min_height)
        }
      end
    end

    context 'adding new conditions' do
      describe 'successfully' do
        it {
          click_on('Add new conditions')
          within '#new_condition_swell' do
            choose(option: 1)
            fill_in 'Min Height', with: 2
            fill_in 'Max Height', with: 10
            fill_in 'Min Period', with: 10
            find('label', text: 'Nw').click
            click_on("Add Conditions")
          end
          expect(page).to have_content(
            /successfully added swell conditions to #{ swell.spot.name }/i)
        }
      end

      describe 'submits incomplete form' do
        it {
          click_on('Add new conditions')
          within '#new_condition_swell' do
            click_on("Add Conditions")
            expect(page).to have_content(/Please review the problems below:/i)
            expect(page).to have_content(/rating can't be blank/i)
            expect(page).to have_content(/min height can't be blank/i)
            expect(page).to have_content(/min period can't be blank/i)
          end
        }
      end

      describe 'resets form' do
        it {
          click_on('Add new conditions')
          within '#new_condition_swell' do
            fill_in 'Min Height', with: 'dummy data'
            click_on("Reset")
          end
          expect(page).to_not have_content('dummy data')
        }
      end
    end

    context 'deleting existing conditions' do
      describe 'successfully' do
        it {
          within('.accordion-item.is-active') do
            click_on('Delete conditions')
          end
          within('.reveal') do
            click_on('Delete')
          end
          expect(page).to_not have_content(swell.min_height)
          expect(page).to_not have_content(swell.min_period)
        }
      end
    end

  end
end
