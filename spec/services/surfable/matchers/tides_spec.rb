require 'rails_helper'
require 'support/day_forecast_stub'

RSpec.describe Surfable::Matchers::Tides do

  let(:forecast_tides) { Forecast::Day.new(day_forecast_stub).tides }

  describe 'Attributes' do

    describe 'Times' do
      context 'with 3 hours before high, 3 hours before low' do
        let(:user_tides) do
          t = FactoryBot.build(:spot_session_with_conditions).conditions.tide
          t.position_high_low = [0, -3]
          t.position_low_high = [0, -3]
          t
        end
        subject { described_class.call(user_tides, forecast_tides) }

        it {
          expect(subject.times.count).to eq(4)
          expect(time_str(subject.times[0][:from])).to eq('8:07')
          expect(time_str(subject.times[0][:to])).to eq('11:07')
          expect(time_str(subject.times[1][:from])).to eq('20:32')
          expect(time_str(subject.times[1][:to])).to eq('23:32')
          expect(time_str(subject.times[2][:from])).to eq('2:06')
          expect(time_str(subject.times[2][:to])).to eq('5:06')
          expect(time_str(subject.times[3][:from])).to eq('14:26')
          expect(time_str(subject.times[3][:to])).to eq('17:26')
          time_from_less_than_time_to(subject)
        }
      end

      context 'full range from high to low' do
        let(:user_tides) do
          t = FactoryBot.build(:spot_session_with_conditions).conditions.tide
          t.position_high_low = [3, -3]
          t.position_low_high = [0, 0]
          t
        end
        subject { described_class.call(user_tides, forecast_tides) }

        it {
          expect(subject.times.count).to eq(2)
          expect(time_str(subject.times.first[:from])).to eq('5:06')
          expect(time_str(subject.times.first[:to])).to eq('11:07')
          time_from_less_than_time_to(subject)
        }
      end

      context 'full range from low to high' do
        let(:user_tides) do
          t = FactoryBot.build(:spot_session_with_conditions).conditions.tide
          t.position_high_low = [0, 0]
          t.position_low_high = [3, -3]
          t
        end
        subject { described_class.call(user_tides, forecast_tides) }

        it {
          expect(subject.times.count).to eq(2)
          expect(time_str(subject.times.first[:from])).to eq('11:07')
          expect(time_str(subject.times.first[:to])).to eq('17:26')
          time_from_less_than_time_to(subject)
        }
      end

      context 'full range' do
        let(:user_tides) do
          t = FactoryBot.build(:spot_session_with_conditions).conditions.tide
          t.position_high_low = [3, -3]
          t.position_low_high = [3, -3]
          t
        end
        subject { described_class.call(user_tides, forecast_tides) }

        it {
          expect(subject.times.count).to eq(1)
          expect(time_str(subject.times.first[:from])).to eq('0:00')
          expect(time_str(subject.times.first[:to])).to eq('23:59')
          time_from_less_than_time_to(subject)
        }
      end

      context 'no range offsets' do
        let(:user_tides) do
          t = FactoryBot.build(:spot_session_with_conditions).conditions.tide
          t.position_high_low = [0, 0]
          t.position_low_high = [0, 0]
          t
        end
        subject { described_class.call(user_tides, forecast_tides) }
        it {
          expect(subject.times.count).to eq(4)
          expect(time_str(subject.times[0][:from])).to eq('11:07')
          expect(time_str(subject.times[0][:to])).to eq('11:07')
        }
      end

    end

    describe 'size' do
      let(:user_tides) do
        t = FactoryBot.build(:spot_session_with_conditions).conditions.tide
        t.position_high_low = [3, -3]
        t.position_low_high = [0, 0]
        t
      end
      subject { described_class.call(user_tides, forecast_tides) }
      it { expect(subject.match_size).to eq(true) }
    end
  end

  def time_from_less_than_time_to(s)
    subject.times.each do |time|
      expect(time[:from] < time[:to]).to eq(true)
    end
  end

  def time_str(t)
    t.strftime("%k:%M").strip
  end

end
