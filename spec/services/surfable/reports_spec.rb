require 'rails_helper'
require 'support/day_forecast_stub'

RSpec.describe Surfable::Reports do
  
  let(:spot_session) { FactoryBot.build(:spot_session_with_conditions) }
  let(:window_times) { Surfable::Windows.new(spot_session, forecast).times }
  let(:forecast) { Forecast::Day.new(day_forecast_stub) }

  subject { described_class.new(spot_session, forecast, window_times) }

  context 'With a good forecast' do
    it { subject }
  end

  context 'With a bad forecast' do

  end

end
