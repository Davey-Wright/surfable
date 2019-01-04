require 'rails_helper'
require 'support/day_forecast_stub'

RSpec.describe Surfable::Forecaster do

  let(:forecast) { 5.times.collect { Forecast::Day.new(day_forecast_stub) } }

  subject { described_class.call(spots, forecast) }

  describe 'surfable forecast for multiple spots' do
    let(:spots) { 3.times.collect { FactoryBot.create(:spot_with_conditions) } }
  end

  describe 'surfable forecast for one spot' do
    let(:spots) { FactoryBot.create(:spot_with_conditions) }
    it {
      spot.tide.rising = [1, 2, 3]
      spot.tide.dropping = [3, 4, 5]
      subject
    }
  end
end
