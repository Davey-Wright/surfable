require 'rails_helper'
require 'support/day_forecast_stub'

RSpec.describe Surfable::Matchers::Conditions do

  let(:session_conditions) do
    t = FactoryBot.build(:spot_session_with_conditions)
    t.conditions.tide.position_high_low = [0, -3]
    t.conditions.tide.position_low_high = [0, -3]
    t.conditions
  end

  context 'With surfable swell and wind' do
    let(:forecast_hour) { Forecast::Day.new(day_forecast_stub).hours.first }
    subject { described_class.call(1, forecast_hour, session_conditions) }

    it {
      expect(subject.time).to eq(1)
      expect(subject.surfable).to eq(true)
      expect(subject.swell.min_height).to eq(0)
      expect(subject.swell.max_height).to eq(nil)
      expect(subject.swell.period).to eq(2)
      expect(subject.swell.surfable).to eq(true)
      expect(subject.wind.speed).to eq(-13)
      expect(subject.wind.surfable).to eq(true)
    }
  end

  context 'With no surfable swell or wind' do
    let(:forecast_hour) do
      forecast_stub = day_forecast_stub
      forecast_stub.hours.first.swell[:height] = 3
      forecast_stub.hours.first.swell[:period] = 6
      forecast_stub.hours.first.swell[:direction] = 250
      forecast_stub.hours.first.wind[:speed] = 19
      forecast_stub.hours.first.wind[:gusts] = 30
      forecast_stub.hours.first.wind[:direction] = 250
      Forecast::Day.new(forecast_stub).hours.first
    end
    subject { described_class.call(1, forecast_hour, session_conditions) }
    it {
      expect(subject.time).to eq(1)
      expect(subject.surfable).to eq(false)
      expect(subject.swell.min_height).to eq(-2)
      expect(subject.swell.max_height).to eq(nil)
      expect(subject.swell.period).to eq(-4)
      expect(subject.swell.surfable).to eq(false)
      expect(subject.wind.speed).to eq(1)
      expect(subject.wind.surfable).to eq(false)
    }
  end

  context 'With surfable swell, and not surfable wind' do
    let(:forecast_hour) do
      forecast_stub = day_forecast_stub
      forecast_stub.hours.first.wind[:speed] = 19
      forecast_stub.hours.first.wind[:gusts] = 30
      forecast_stub.hours.first.wind[:direction] = 250
      Forecast::Day.new(forecast_stub).hours.first
    end
    subject { described_class.call(1, forecast_hour, session_conditions) }
    it {
      expect(subject.time).to eq(1)
      expect(subject.surfable).to eq(false)
      expect(subject.swell.min_height).to eq(0)
      expect(subject.swell.max_height).to eq(nil)
      expect(subject.swell.period).to eq(2)
      expect(subject.swell.surfable).to eq(true)
      expect(subject.wind.speed).to eq(1)
      expect(subject.wind.surfable).to eq(false)
    }
  end

end
