require 'rails_helper'

# Test that

# unsuccessfully
#   Non authorized users cannot view spots and are redirected to login page
#   if spot cannot be found user redirected to 404 page
# successfully
#   spot attributes are displayed
#   swell, wind, tide accordions are displayed

feature 'User views spot', js: true do
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
    login_as(spot.user) unless test.metadata[:logged_out]
  end

  context 'unsuccessfully' do
    scenario 'when visitor not registered or logged in they cannot view spots index', :logged_out do
      visit spots_path
      expect(page).to have_content(/You need to sign in or sign up before continuing./i)
      expect(page).to_not have_content(/shaka/i)
      expect(page).to have_current_path(new_user_session_path)
    end

    scenario 'when visitor is not registered or logged in they cannot view a spot', :logged_out do
      visit spot_path(spot)
      expect(page).to have_content(/You need to sign in or sign up before continuing./i)
      expect(page).to_not have_content(/shaka/i)
      expect(page).to have_current_path(new_user_session_path)
    end

    scenario 'when spot cannot be found' do
      visit spot_path(100)
      expect(page).to have_content(/the page you were looking for was not found./i)
      expect(page).to have_link('Click here to go back to the Surf Forecasts page.')
    end
  end

  context 'successfully' do
    scenario 'when user is logged in they can view spots index' do
      visit spots_path
      expect(page).to have_content(/shaka/i)
      expect(page).to have_link('Add new spot')
    end

    scenario 'user reads attributes with nil values' do
      spot.wave_shape = nil
      spot_info = page.find('.spot_info')
      expect(spot_info).to have_content 'N/A'
    end

    scenario 'when user is logged in they can view a spot' do
      visit spot_path(spot)
      expect(page).to have_link('Edit')
      expect(page).to have_link('Delete')

      spot_info = page.find('.spot_info')
      expect(spot_info).to have_content(/shaka/i)
      expect(spot_info).to have_content(/crumbling/i, /steep/i)
      expect(spot_info).to have_content(/beach/i)
      expect(spot_info).to have_content(/left/i, /right/i)
      expect(spot_info).to have_content(/short/i, /average/i)
      expect(spot_info).to have_content(/slow/i, /average/i)

      conditions = page.find('ul.accordion')
      expect(conditions).to have_content(/swell/i)
      expect(conditions).to have_content(/tide/i)
      expect(conditions).to have_content(/wind/i)
    end
  end
end
