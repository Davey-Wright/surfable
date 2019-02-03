require 'rails_helper'

# Test that
#   Non authenticated users cannot update spot
#   Form displays attribute fields and current values
#   Form displays necessary validations
#   Form fields reset to original values
#   Spot can be updated with minimal requirements
#   All form attributes can be updated
#   Spot page displays spots contents

feature 'User updates Spot', js: true do
  let(:spot) do
    FactoryBot.create(:spot,
                      name: 'shaka',
                      wave_break_type: %w[beach],
                      wave_shape: %w[crumbling steep],
                      wave_direction: %w[left right],
                      wave_length: %w[short average],
                      wave_speed: %w[slow average])
  end

  before(:each) do |test|
    login_and_visit_spot unless test.metadata[:logged_out]
    @scoped_form = "#edit_spot_#{spot.id}"
  end

  context 'unsuccessfully' do
    scenario 'when visitor is not registered or logged in', :logged_out do
      visit spot_path(spot)
      expect(page).to have_content(/You need to sign in or sign up before continuing./i)
      expect(page).to have_current_path(new_user_session_path)
    end

    scenario 'when user deletes name and submits form' do
      within @scoped_form do
        fill_in 'Name', with: ''
        click_on('Update Spot')
      end
      expect(page).to have_content(/please review the problems below:/i)
      expect(page).to have_content(/name can't be blank/i)
    end

    scenario 'when user resets the form original values should be restored' do
      within @scoped_form do
        fill_in 'Name', with: 'Reset this Name'
        click_on('Reset')
      end
      expect(page).to_not have_content(/reset this name/i)
      expect(find_field('Name').value).to eq('shaka')
    end
  end

  context 'successfully' do
    scenario 'when user updates all attributes' do
      within @scoped_form do
        fill_in 'Name', with: 'Melakaville'
        find(:css, '#spot_latitude').set(100)
        find(:css, '#spot_longitude').set(100)
        find('label', text: 'Beach').click
        find('label', text: 'Left').click
        find('label', text: 'Short').click
        find('label', text: 'Crumbling').click
        find('label', text: 'Slow').click
        click_on('Update Spot')
      end
      scoped_node = page.find('.spot_info')
      expect(scoped_node).to have_content(/melakaville/i)
      expect(scoped_node).to_not have_content(/beach/i)
      expect(scoped_node).to_not have_content(/point/i)
      expect(scoped_node).to_not have_content(/left/i)
      expect(scoped_node).to_not have_content(/short/i)
      expect(scoped_node).to_not have_content(/crumbling/i)
      expect(scoped_node).to_not have_content(/slow/i)
    end

    scenario 'the modal closes and spot page is updated' do
      within @scoped_form do
        fill_in 'Name', with: 'Melakaville'
        click_on('Update Spot')
      end
      scoped_node = page.find('ul.accordion')
      expect(scoped_node).to have_content(/swell/i)
      expect(scoped_node).to have_content(/tides/i)
      expect(scoped_node).to have_content(/wind/i)
    end
  end

  def login_and_visit_spot
    login_as(spot.user)
    visit spot_path(spot)
    click_on('Edit')
  end
end
