require 'rails_helper'
require 'support/day_forecast_stub'

RSpec.describe Surfable::Matchers::Swells do
  let(:spot) { FactoryBot.create(:spot_with_conditions) }
  subject { described_class.call(spot, forecast_day) }

  describe 'non surfable condition' do
    forecast_stub = day_forecast_stub
    let(:forecast_day) { Forecast::Day.new(forecast_stub) }

    context 'height' do
      it {
        forecast_stub.hours.each { |hour| hour.swell[:height] = 0.5 }
        expect(subject.forecast.length).to eq(0)
      }
    end

    context 'period' do
      it {
        forecast_stub.hours.each { |hour| hour.swell[:period] = 1 }
        expect(subject.forecast.length).to eq(0)
      }
    end

    context 'direction' do
      it {
        forecast_stub.hours.each { |hour| hour.swell[:direction] = 90 }
        expect(subject.forecast.length).to eq(0)
      }
    end

    context 'max_height' do
      it {
        forecast_stub.hours.each { |hour| hour.swell[:period] = 3 }
        expect(subject.forecast.length).to eq(0)
      }
    end
  end

  describe 'surfable conditions' do
    forecast_stub = day_forecast_stub
    let(:forecast_day) { Forecast::Day.new(forecast_stub) }

    it { expect(subject.forecast.length).to eq(1) }

    it 'should only forecast highest rated spot condtions' do
      lowest_rating = spot.swells.min_by(&:rating).rating
      highest_rating = spot.swells.max_by(&:rating).rating
      ratings = subject.forecast.first.collect { |f| f[:rating] }
      expect(ratings.exclude?(lowest_rating)).to eq(true)
      expect(ratings.include?(highest_rating)).to eq(true)
    end

    context 'with multiple blocks of surfable times' do
      it {
        forecast_stub.hours[4].swell[:height] = 0.5
        expect(subject.forecast.length).to eq(2)
      }
    end
  end
end
