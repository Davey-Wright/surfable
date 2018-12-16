require 'rails_helper'

feature 'Create Tide Condition', js: true do

  let(:tide) { FactoryBot.create(:tide_conditions) }

  before(:each) do
    login_as(tide.spot.user)
    visit spot_path(tide.spot)
    click_on('Tide')
  end

  context 'logged in user' do

    context 'viewing conditions' do
      describe 'with existing conditions' do
        it {
          expect(page).to have_link('Add new conditions')
          expect(page).to have_link('Delete conditions')
          expect(page).to have_content(tide.rating)
          expect(page).to have_content(tide.rising.first)
          expect(page).to have_content(tide.dropping.first)
          expect(page).to have_content(tide.size.first)
        }
      end

      describe 'with no existing conditions' do
        it {
          tide.destroy
          visit spot_path(tide.spot)
          click_on('Tide')
          expect(page).to have_link('Add new conditions')
          expect(page).to_not have_link('Delete conditions')
          expect(page).to_not have_content(tide.rating)
          expect(page).to_not have_content(tide.rising.first)
          expect(page).to_not have_content(tide.dropping.first)
          expect(page).to_not have_content(tide.size.first)
        }
      end
    end

    context 'adding new conditions' do
      describe 'successfully' do
        it {
          click_on('Add new conditions')
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
            /successfully added tide conditions to #{ tide.spot.name }/i)
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
          within '#new_condition_tide' do
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
          expect(page).to_not have_content(tide.rising.first)
          expect(page).to_not have_content(tide.dropping.first)
          expect(page).to_not have_content(tide.size.first)
        }
      end
    end

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
