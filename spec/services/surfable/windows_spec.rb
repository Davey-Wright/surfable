require 'rails_helper'
require 'support/day_forecast_stub'

RSpec.describe Surfable::Windows do

  let(:forecast) { Forecast::Day.new(day_forecast_stub) }
  let(:spot_session) do
    t = FactoryBot.build(:spot_session_with_conditions)
    t.conditions.tide.position_high_low = [0, -3]
    t.conditions.tide.position_low_high = [0, -3]
    t
  end
  subject { described_class.new(spot_session, forecast) }

  it {
    expect(subject.times.count).to eq(2)
    expect(time_str(subject.times[0][:from])).to eq('8:07')
    expect(time_str(subject.times[0][:to])).to eq('11:07')
    expect(time_str(subject.times[1][:from])).to eq('14:26')
    expect(time_str(subject.times[1][:to])).to eq('17:04')
  }

  def t(str)
    Time.parse(str)
  end

  def time_str(t)
    t.strftime("%k:%M").strip
  end

end
