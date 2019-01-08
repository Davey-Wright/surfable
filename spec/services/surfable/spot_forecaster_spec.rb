require 'rails_helper'
require 'support/day_forecast_stub'

RSpec.describe Surfable::SpotForecaster do

  let(:spot) { FactoryBot.create(:spot_with_conditions) }
  subject { described_class.call(spot, forecast_day) }

  describe 'no surfable conditions' do
    let(:forecast_stub) { day_forecast_stub }
    let(:forecast_day) { Forecast::Day.new(forecast_stub) }

    context 'no surfable winds' do
      it { forecast_stub.hours.each { |hour| hour.wind[:speed] = 50 }
        expect(subject).to eq(nil) }
    end

    context 'no surfable swells' do
      it { forecast_stub.hours.each { |hour| hour.swell[:height] = 1 }
        expect(subject).to eq(nil) }
    end
  end

  describe 'surfable conditions' do
    let(:forecast_stub) { day_forecast_stub }
    let(:forecast_day) { Forecast::Day.new(forecast_stub) }
    
    it { subject }
  end

end
