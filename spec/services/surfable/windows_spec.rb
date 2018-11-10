require 'rails_helper'
require 'support/day_forecast_stub'

RSpec.describe Surfable::Windows do

  let(:forecast) { Forecast::Day.new(day_forecast_stub) }
  let(:spot_session) do
    t = FactoryBot.build(:spot_session_with_conditions)
    t.conditions.tide.position_high_low = [0, -3]
    t.conditions.tide.position_low_high = [0, -2.5]
    t
  end
  subject { described_class.call(spot_session, forecast) }

  describe 'time attribute' do
    it {
      expect(subject.times.count).to eq(2)
      expect(time_str(subject.times[0][:from])).to eq('8:07')
      expect(time_str(subject.times[0][:to])).to eq('11:07')
      expect(time_str(subject.times[1][:from])).to eq('14:56')
      expect(time_str(subject.times[1][:to])).to eq('17:04')
    }

  end

  describe 'reports attribute' do
    it {
      expect(subject.reports.count).to eq(subject.times.count)
      expect(subject.reports[0].count).to eq(subject.times[0][:to].hour - subject.times[0][:from].hour + 1)
      expect(subject.reports[1].count).to eq(subject.times[1][:to].hour - subject.times[1][:from].hour + 1)
    }
  end

  def t(str)
    Time.parse(str)
  end

  def time_str(t)
    t.strftime("%k:%M").strip
  end

end
