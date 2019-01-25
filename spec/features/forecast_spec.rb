require 'rails_helper'

describe 'Forecasts', type: :feature do
  let(:spot) { FactoryBot.create(:spot_with_conditions) }

  context 'A non registered or logged out user' do
    scenario 'tries to visit the forecasts page' do
      section 'melaka broo' do
        visit(forecast_path)
        expect(page).to have_content('You need to sign in or sign up before continuing.')
      end
    end
  end

  context 'A logged in user' do
    
  end

end
