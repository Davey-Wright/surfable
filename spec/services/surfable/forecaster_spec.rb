require 'rails_helper'
require 'support/day_forecast_stub'

RSpec.describe Surfable::Forecaster do

  let(:forecast) {
    f = 5.times.collect { day_forecast_stub }
    Forecast::Days.new(f)
  }
  subject { described_class.call(spots, forecast) }

  describe 'surfable forecast with real forecast' do
    let(:spots) { FactoryBot.create(:spot_with_conditions) }
    let(:forecast) {
      f = Forecast::Mappers.call
      forecast = Forecast::Days.new(f)
    }
    it {
      expect(subject.forecast.length).to eq(5)
      expect(subject.forecast.first[:spots].length).to eq(1)
    }
  end

  describe 'surfable forecast for multiple spots' do
    let(:spots) { 3.times.collect { FactoryBot.create(:spot_with_conditions) } }

    context 'all spots are surfable' do
      it {
        expect(subject.forecast.first[:spots].length).to eq(3)
        expect(subject.forecast.length).to eq(5)
      }
    end
    context 'only two spots are surfable' do
      it {
        spots[0].tide = nil
        expect(subject.forecast.first[:spots].length).to eq(2)
      }
    end

    context 'only one spot is surfable' do
      it {
        spots[0].tide = nil
        spots[1].tide = nil
        expect(subject.forecast.first[:spots].length).to eq(1)
      }
    end
  end

  describe 'surfable forecast for one spot' do
    let(:spots) { FactoryBot.create(:spot_with_conditions) }
    it {
      spots.tide.rising = [1, 2, 3]
      spots.tide.dropping = [3, 4, 5]
    }
  end
end
