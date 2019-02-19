require 'rails_helper'

# Test
  # Read
    # tide conditions displayed after user clicks tide on accordion
      # all tides are displayed
      # all condition attributes are displayed

  # Create
    # Add new spot button displays form with tide attribute fields
      # creates spot successfully when required fields filled and form submitted
        # spot page updated after tide created

      # tide not created when required form fields not filled in and form submitted
        # form displays validation errors

  # Delete
    # click delete displays confirmation modal
      # successfully deletes tide after user clicks confirm
      # unsuccessfully deletes tide after user clicks cancel

feature 'User can Create, Read, Delete tide conditions', js: true do
  let(:spot) do
    FactoryBot.create(:spot_with_conditions)
  end

  before(:each) do |test|
    @tide = spot.tide
    login_as(spot.user)
    visit_spot unless test.metadata[:no_tide]
  end

  describe 'Read tide' do
    scenario 'with tide conditions currently saved' do
      expect(page).to_not have_link 'Add new conditions'
      should_display_all_attributes(page)
    end

    scenario 'without tide conditions saved', :no_tide do
      spot.tide = nil
      visit_spot
      expect(page).to have_link 'Add new conditions'
    end

    scenario 'attributes with nil values' do
      within '#spot_tide' do
        expect(page).to have_content 'Not Defined'
      end
    end
  end

  describe 'Create tide' do
    context 'successfully' do
      scenario 'when user fills required form fields and submits form', :no_tide do
        spot.tide = nil
        visit_spot
        click_on('Add new conditions')
        within '#new_condition_tide' do
          within '.condition_tide_rising' do
            first(:label, 'Low').click
            first(:label, '1st').click
            first(:label, '2nd').click
            first(:label, 'Mid').click
          end
          within '.condition_tide_dropping' do
            first(:label, 'Low').click
            first(:label, '1st').click
            first(:label, '2nd').click
            first(:label, 'Mid').click
          end
          first(:label, '7').click
          first(:label, '8').click
          first(:label, '9').click
          click_on('Add Conditions')
        end

        expect(page).to have_content "Successfully added Tide conditions to #{spot.name}"
        within 'ul.accordion' do
          click_on('Tide')
        end
        should_display_all_attributes(page)
      end
    end

    context 'unsuccessfully' do
      scenario 'when user skips required form fields and submits form', :no_tide do
        spot.tide = nil
        visit_spot
        click_on('Add new conditions')
        within '#new_condition_tide' do
          click_on('Add Conditions')
        end

        assert_text 'Please review the problems below:'
        expect(page).to have_content "Size can't be blank"
      end
    end
  end

  describe 'Update tide' do
    before(:each) do
      within '#spot_tide' do
        click_on('Edit')
        @scoped_form = "#edit_condition_tide_#{spot.tide.id}"
      end
    end

    context 'successfully' do
      scenario 'when user fills required form fields and submits form' do
        within @scoped_form do
          within '.condition_tide_rising' do
            first(:label, 'Low').click
            first(:label, '1st').click
            first(:label, '2nd').click
            first(:label, 'Mid').click
          end
          first(:label, '7').click
          first(:label, '8').click
          click_on('Update Conditions')
        end

        expect(page).to have_text 'Tide conditions were successfully updated'
        within 'ul.accordion' do
          click_on('Tide')
        end
        should_display_updated_attributes(page)
      end
    end

    context 'unsuccessfully' do
      scenario 'when user skips required form fields and submits form' do
        within @scoped_form do
          first(:label, '7').click
          first(:label, '8').click
          first(:label, '9').click
          click_on('Update Conditions')
        end
        expect(page).to have_text 'Please review the problems below:'
        expect(page).to have_content "Size can't be blank"
      end
    end
  end

  describe 'Delete tide' do
    before(:each) do
      scoped_node = '#spot_tide'
      within(scoped_node) do
        click_on('Delete')
      end
    end

    scenario 'successfully' do
      click_on('Confirm')
      assert page.has_no_text? '7 8 9'
      assert page.has_no_text? 'low 1st 2nd Mid'
    end

    scenario 'cancels delete' do
      click_on('Cancel')
      should_display_all_attributes(page)
    end
  end

  def visit_spot
    visit spot_path(spot)
    within 'ul.accordion' do
      click_on('Tide')
    end
  end

  def should_display_all_attributes(page)
    scoped_node = '#spot_tide'
    within scoped_node do
      expect(page.body).to have_content 'Low 1st 2nd Mid'
      expect(page.body).to have_content '7 8 9'
      expect(page).to have_link('Delete')
    end
  end

  def should_display_updated_attributes(page)
    scoped_node = '#spot_tide'
    within scoped_node do
      expect(page.body).to_not have_content 'Low 1st 2nd Mid'
      expect(page.body).to_not have_content '7, 8'
    end
  end
end
