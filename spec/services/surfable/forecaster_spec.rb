require 'rails_helper'
require 'support/day_forecast_stub'

RSpec.describe Surfable::Forecaster do
  let(:forecast) do
    forecast_stub = Array.new(5) { day_forecast_stub }
    Forecast::Days.new(forecast_stub)
  end

  subject { described_class.call(spots, forecast) }

  describe 'surfable forecast for multiple spots' do
    let(:spots) { Array.new(3) { FactoryBot.create(:spot_with_conditions) } }

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
