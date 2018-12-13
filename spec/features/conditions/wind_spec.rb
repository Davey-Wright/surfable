require 'rails_helper'

feature 'Create wind Condition', js: true do
  let(:wind) { FactoryBot.create(:wind_conditions) }

  before(:each) do
    login_as(wind.spot.user)
    visit spot_path(wind.spot)
    click_on('Wind')
  end

  context 'logged in user' do

    context 'viewing conditions' do
      describe 'with existing conditions' do
        it {
          expect(page).to have_link('Add new conditions')
          expect(page).to have_link('Delete conditions')
          expect(page.body).to have_content(wind.rating)
          expect(page.body).to have_content(wind.name.first)
          expect(page.body).to have_content(wind.speed)
        }
      end

      describe 'with no existing conditions' do
        it {
          wind.destroy
          visit spot_path(wind.spot)
          click_on('Wind')
          expect(page).to have_link('Add new conditions')
          expect(page).to_not have_link('Delete conditions')
          expect(page.body).to_not have_content(wind.rating)
          expect(page.body).to_not have_content(wind.speed)
        }
      end
    end

    context 'adding new conditions' do
      describe 'successfully' do
        it {
          click_on('Add new conditions')
          within '#new_condition_wind' do
            choose(option: 1)
            find('label', text: 'Onshore').click
            find('label', text: 'Ne').click
            fill_in('condition_wind[speed]', with: 2)
            click_on("Add Conditions")
          end
          expect(page).to have_content(
            /successfully added new wind conditions to #{ wind.spot.name }/i)
        }
      end

      describe 'submits incomplete form' do
        it {
          click_on('Add new conditions')
          expect_validations
        }
      end

      describe 'resets form' do
        it {
          click_on('Add new conditions')
          within '#new_condition_wind' do
            choose(option: 1)
            click_on("Reset")
          end
          expect_validations
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
          expect(page.body).to have_content(wind.name.first)
          expect(page.body).to have_content(wind.speed)
        }
      end
    end

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
