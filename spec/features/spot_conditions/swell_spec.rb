require 'rails_helper'

# Test
  # Read
    # swell conditions displayed after user clicks swell on accordion
      # all swells are displayed
      # all condition attributes are displayed

  # Create
    # Add new spot button displays form with swell attribute fields
      # creates spot successfully when required fields filled and form submitted
        # spot page updated after swell created

      # swell not created when required form fields not filled in and form submitted
        # form displays validation errors

  # Delete
    # click delete displays confirmation modal
      # successfully deletes swell after user clicks confirm
      # unsuccessfully deletes swell after user clicks cancel

feature 'User can Create, Read, Delete swell conditions', js: true do
  let(:spot) do
    FactoryBot.create(:spot_with_conditions)
  end

  before(:each) do
    login_as(spot.user)
    visit spot_path(spot)
  end

  describe 'Read swells' do
    scenario 'user views their spots swell conditions' do
     click_and_view_swells
      swells = spot.swells
      expect(page).to have_link 'Add new conditions'
      should_display_all_conditions(page, swells)
    end

    scenario 'user reads attributes with nil values' do
      swell = spot.swells.first
      swell.max_height = 0
      swell.direction = []
      scoped_node = "#spot_swell_#{swell.id}"

      click_and_view_swells
      within scoped_node do
        page.find("li", text: 'Not Defined')
      end
    end
  end

  describe 'Create swells' do
    context 'successfully' do
      scenario 'when user fills required form fields and submits form' do
       click_and_view_swells
        click_on('Add new conditions')
        within '#new_condition_swell' do
          # rating attribute
          choose(option: 4)
          fill_in 'Min Height', with: 123
          fill_in 'Max Height', with: 456
          fill_in 'Min Period', with: 789
          find('label', text: 'NW').click
          click_on('Add Conditions')
        end

        expect(page).to have_content "Successfully added Swell conditions to #{spot.name}"
        click_and_view_swells
        should_display_all_attributes(page)
      end
    end

    context 'unsuccessfully' do
      scenario 'when user skips required form fields and submits form' do
        click_and_view_swells
        click_on('Add new conditions')
        within '#new_condition_swell' do
          click_on('Add Conditions')
          have_css('.form_errors', text: 'Please review the problems below:')
          have_css('.invalid-feedback', text: "Rating can't be blank")
          have_css('.condition_swell_min_height .error', text: "Min height can't be blank")
          have_css('.condition_swell_min_period .error', text: "Min period can't be blank")
        end
      end

      scenario 'when user resets form' do
       click_and_view_swells
        click_on('Add new conditions')
        within '#new_condition_swell' do
          fill_in 'Min Height', with: 'dummy data'
          click_on('Reset')
        end
        expect(page).to_not have_content 'dummy data'
      end
    end
  end

  describe 'Delete swells' do
    before(:each) do
     click_and_view_swells
      @swell = spot.swells.first
      scoped_node = "#spot_swell_#{@swell.id}"
      within(scoped_node) do
        click_on('Delete')
      end
    end

    scenario 'successfully' do
      click_on('Confirm')
      assert page.has_no_text? @swell.min_height
      assert page.has_no_text? @swell.min_period
    end

    scenario 'cancels delete' do
      click_on('Cancel')
      expect(page.body).to have_content @swell.rating
      expect(page.body).to have_content @swell.min_period
      expect(page.body).to have_content @swell.min_height
      expect(page.body).to have_content @swell.max_height
    end
  end

  def click_and_view_swells
    within 'ul.accordion' do
      click_on('Swell')
    end
  end

  def should_display_all_conditions(page, swells)
    swells.each do |swell|
      scoped_node = "#spot_swell_#{swell.id}"
      within scoped_node do
        expect(page.body).to have_content swell.min_period
        expect(page.body).to have_content swell.min_height
        expect(page.body).to have_content swell.max_height
        expect(page.body).to have_content swell.direction.first
        expect(page).to have_link 'Delete'
      end
    end
  end

  def should_display_all_attributes(page)
    swell = spot.swells.last
    scoped_node = "#spot_swell_#{swell.id}"
    within scoped_node do
      expect(page.body).to have_css 'li.star_4'
      expect(page.body).to have_content '123'
      expect(page.body).to have_content '456'
      expect(page.body).to have_content '789'
      expect(page.body).to have_content 'NW'
      expect(page).to have_link('Delete')
    end
  end
end
