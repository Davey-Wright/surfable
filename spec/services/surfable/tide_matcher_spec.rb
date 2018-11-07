require 'rails_helper'
require 'support/day_forecast_stub'

RSpec.describe Surfable::TideMatcher do
  let(:spot_session) { FactoryBot.build(:spot_session_with_conditions).conditions.tide }
  let(:day_forecast) { Forecast::Day.new(day_forecast_stub).tides }

  describe 'Attributes' do
    describe 'times' do
      context '3 hours before low, 3 hours after low' do
        subject { described_class.call(spot_session, day_forecast) }
        it { expect(subject.times.count).to eq(2) }
        it { expect(time_str(subject.times.first[:from])).to eq('8:07') }
        it { expect(time_str(subject.times.first[:to])).to eq('14:07') }
      end
    end

    describe 'size' do
      subject { described_class.call(spot_session, good_forecast) }

    end
  end

  def time_str(t)
    t.strftime("%k:%M").strip
  end

end
