require 'rails_helper'
require 'support/day_forecast_stub'

RSpec.describe Surfable::SpotForecaster do

  let(:forecast_day) { day_forecast_stub }
  let(:spot) { FactoryBot.create(:spot_with_conditions) }

  before(:each) do
    spot.tide.rising = [1, 2, 3]
    spot.tide.dropping = [3, 4, 5]
  end

  subject { described_class.new(spot, forecast_day) }

  describe 'tides forecast method' do
    it {
      subject.tides_forecast
      expect(subject.times.count).to eq(2)
      expect(time_start(0)).to eq('11:07')
      expect(time_end(0)).to eq('14:07')
      expect(time_start(1)).to eq('7:06')
      expect(time_end(1)).to eq('10:06')
    }
  end

  describe 'swells_forecast' do

  end

  describe '' do

  end

end
