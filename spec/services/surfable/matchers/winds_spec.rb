require 'rails_helper'
require 'support/day_forecast_stub'

RSpec.describe Surfable::Matchers::Winds do
  let(:spot) { FactoryBot.create(:spot_with_conditions) }
  subject { described_class.call(spot, forecast_day) }

  describe 'non surfable condition' do
    forecast_stub = day_forecast_stub
    let(:forecast_day) { Forecast::Day.new(forecast_stub) }

    context 'speed doesnt match any spot conditions' do
      it {
        forecast_stub.hours.each do |hour|
          hour.wind[:speed] = 50
          hour.wind[:gusts] = 100
          hour.wind[:direction] = 90
        end
        expect(subject.forecast.length).to eq(0)
      }
    end

    context 'direction doesnt match any spot conditions' do
      it {
        forecast_stub.hours.each do |hour|
          hour.wind[:speed] = 3
          hour.wind[:gusts] = 2
          hour.wind[:direction] = 270
        end
        expect(subject.forecast.length).to eq(0)
      }
    end
  end

  describe 'surfable conditions' do
    forecast_stub = day_forecast_stub
    let(:forecast_day) { Forecast::Day.new(forecast_stub) }

    it {
      forecast_stub.hours.each do |hour|
        hour.wind[:speed] = 3
        hour.wind[:gusts] = 2
        hour.wind[:direction] = 90
      end
      expect(subject.forecast.length).to eq(1)
    }

    it 'should only forecast highest rated spot condtions' do
      lowest_rating = spot.winds.min_by(&:rating).rating
      highest_rating = spot.winds.max_by(&:rating).rating
      ratings = subject.forecast.first.collect { |f| f[:rating] }
      expect(ratings.exclude?(lowest_rating)).to eq(true)
      expect(ratings.include?(highest_rating)).to eq(true)
    end

    context 'with multiple blocks of surfable times' do
      it {
        forecast_stub.hours[4].wind[:speed] = 100
        expect(subject.forecast.length).to eq(2)
      }
    end
  end
end
