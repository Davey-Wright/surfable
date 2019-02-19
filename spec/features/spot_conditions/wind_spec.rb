require 'rails_helper'

# Test
  # Read
    # wind conditions displayed after user clicks wind on accordion
      # all winds are displayed
      # all condition attributes are displayed

  # Create
    # Add new spot button displays form with wind attribute fields
      # creates spot successfully when required fields filled and form submitted
        # spot page updated after wind created

      # wind not created when required form fields not filled in and form submitted
        # form displays validation errors

  # Delete
    # click delete displays confirmation modal
      # successfully deletes wind after user clicks confirm
      # unsuccessfully deletes wind after user clicks cancel

feature 'User can Create, Read, Delete wind conditions', js: true do
  let(:spot) do
    FactoryBot.create(:spot_with_conditions)
  end

  before(:each) do
    login_as(spot.user)
    visit spot_path(spot)
    within 'ul.accordion' do
      click_on('Wind')
    end
  end

  describe 'Read winds' do
    scenario 'user views their spots wind conditions' do
      winds = spot.winds
      expect(page).to have_link 'Add new conditions'
      should_display_all_conditions(page, winds)
    end
  end

  describe 'Create winds' do
    context 'successfully' do
      scenario 'when user fills required form fields and submits form' do
        click_on('Add new conditions')
        within '#new_condition_wind' do
          choose(option: 4)
          fill_in 'Speed', with: 123
          find('label', text: 'Onshore').click
          find('label', text: 'NW').click
          click_on('Add Conditions')
        end
        expect(page).to have_text("Successfully added Wind conditions to #{spot.name}")
        within 'ul.accordion' do
          click_on('Wind')
        end
        should_display_all_attributes(page)
      end
    end

    context 'unsuccessfully' do
      scenario 'when user skips required form fields and submits form' do
        click_on('Add new conditions')
        within '#new_condition_wind' do
          click_on('Add Conditions')
        end
        assert_text 'Please review the problems below:'
        expect(page).to have_content "Rating can't be blank"
        expect(page).to have_content "Speed can't be blank"
        expect(page).to have_content "Direction can't be blank"
      end
    end
  end

  describe 'Delete winds' do
    before(:each) do
      @wind = spot.winds.first
      scoped_node = "#spot_wind_#{@wind.id}"
      within(scoped_node) do
        click_on('Delete')
      end
    end

    scenario 'successfully' do
      click_on('Confirm')
      expect(page).to have_text("Successfully deleted Wind conditions from #{spot.name}")
      assert page.has_no_text? @wind.speed
      assert page.has_no_text? @wind.direction.first
    end

    scenario 'cancels delete' do
      click_on('Cancel')
      expect(page.body).to have_content @wind.speed
      expect(page.body).to have_content @wind.direction.first
      expect(page.body).to have_content @wind.name.first
    end
  end

  def should_display_all_conditions(page, winds)
    winds.each do |wind|
      scoped_node = "#spot_wind_#{wind.id}"
      within scoped_node do
        expect(page.body).to have_content wind.name.first
        expect(page.body).to have_content wind.speed
        expect(page.body).to have_content wind.direction.first
        expect(page).to have_link 'Delete'
      end
    end
  end

  def should_display_all_attributes(page)
    wind = spot.winds.last
    scoped_node = "#spot_wind_#{wind.id}"
    within scoped_node do
      expect(page.body).to have_css 'li.star_3'
      expect(page.body).to have_text '4'
      expect(page.body).to have_text 'nw'
      expect(page).to have_link('Delete')
    end
  end
end
