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
    within 'ul.accordion' do
      click_on('Swell')
    end
  end

  describe 'Read swells' do
    scenario 'user views their spots swell conditions' do
      swells = spot.swells
      expect(page).to have_link 'Add new conditions'
      should_display_all_conditions(page, swells)
    end

    scenario 'user reads attributes with nil values' do
      swell = spot.swells.first
      swell.max_height = 0
      swell.direction = []

      scoped_node = "#spot_swell_#{swell.id}"
      expect(scoped_node).to have_content 'N/A'
    end
  end

  describe 'Create swells' do
    context 'successfully' do
      scenario 'when user fills required form fields and submits form' do
        click_on('Add new conditions')
        within '#new_condition_swell' do
          # rating attribute
          choose(option: 4)
          fill_in 'Min Height', with: 123
          fill_in 'Max Height', with: 456
          fill_in 'Min Period', with: 789
          find('label', text: 'Nw').click
          click_on('Add Conditions')
        end

        expect(page).to have_content "Successfully added swell conditions to #{spot.name}"
        within 'ul.accordion' do
          click_on('Swell')
        end

        should_display_all_attributes(page)
      end
    end

    context 'unsuccessfully' do
      scenario 'when user skips required form fields and submits form' do
        click_on('Add new conditions')
        within '#new_condition_swell' do
          click_on('Add Conditions')
        end
        assert page.has_content? 'Please review the problems below:'
        expect(page).to have_content "Rating can't be blank"
        expect(page).to have_content "Min height can't be blank"
        expect(page).to have_content "Min period can't be blank"
      end

      scenario 'when user resets form' do
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

  def should_display_all_conditions(page, swells)
    swells.each do |swell|
      scoped_node = "#spot_swell_#{swell.id}"
      within scoped_node do
        expect(page.body).to have_content swell.rating
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
      expect(page.body).to have_content 'Minimum Height 123'
      expect(page.body).to have_content 'Maximum Height 456'
      expect(page.body).to have_content 'Minimum Period 789'
      expect(page.body).to have_content 'NW'
      expect(page).to have_link('Delete')
    end
  end
end
