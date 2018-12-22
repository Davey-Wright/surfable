require 'rails_helper'
require 'support/day_forecast_stub'

RSpec.describe Surfable::Matchers::Daylight do

  let(:forecast) { Forecast::Day.new(day_forecast_stub) }
  let(:spot) { FactoryBot.create(:spot_with_conditions) }
  let(:tide_times) { Surfable::Matchers::Tides.call(spot, forecast).times }

  subject { described_class.call(tide_times, forecast) }

  

  def t(str)
    Time.parse(str)
  end

  def time_str(t)
    t.strftime("%k:%M").strip
  end

end
