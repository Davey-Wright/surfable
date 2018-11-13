require 'rails_helper'
require 'support/day_forecast_stub'

RSpec.describe Surfable::Matchers::Tides do

  let(:forecast_tides) { Forecast::Day.new(day_forecast_stub) }

  describe 'Attributes' do

    describe 'Times' do
      context 'with 3 hours before high, 3 hours before low' do
        let(:user_tides) do
          t = FactoryBot.build(:conditions)
          t.tide.position_high_low = [0, -3]
          t.tide.position_low_high = [0, -3]
          t
        end
        subject { described_class.call(user_tides, forecast_tides) }

        it {
          first_high = find_first_of_tides('high')
          first_low = find_first_of_tides('low')

          expect(subject.times.count).to eq(4)
          expect(subject.times[0][:from]).to eq(first_low.time - 3.hours)
          expect(subject.times[0][:to]).to eq(first_low.time)
          expect(time_str(subject.times[1][:from])).to eq('20:32')
          expect(time_str(subject.times[1][:to])).to eq('23:32')
          expect(subject.times[2][:from]).to eq(first_high.time - 3.hours)
          expect(subject.times[2][:to]).to eq(first_high.time)
          expect(time_str(subject.times[3][:from])).to eq('14:26')
          expect(time_str(subject.times[3][:to])).to eq('17:26')
          time_from_less_than_time_to(subject)
        }
      end

      context 'with 2.5 hours before high, 2.5 hours before low' do
        let(:user_tides) do
          t = FactoryBot.build(:conditions)
          t.tide.position_high_low = [0, -2.5]
          t.tide.position_low_high = [0, -2.5]
          t
        end
        subject { described_class.call(user_tides, forecast_tides) }

        it {
          first_high = find_first_of_tides('high')
          first_low = find_first_of_tides('low')

          expect(subject.times.count).to eq(4)
          expect(subject.times[0][:from]).to eq(first_low.time - 2.5.hours)
          expect(subject.times[0][:to]).to eq(first_low.time)
          expect(time_str(subject.times[1][:from])).to eq('21:02')
          expect(time_str(subject.times[1][:to])).to eq('23:32')
          expect(subject.times[2][:from]).to eq(first_high.time - 2.5.hours)
          expect(subject.times[2][:to]).to eq(first_high.time)
          expect(time_str(subject.times[3][:from])).to eq('14:56')
          expect(time_str(subject.times[3][:to])).to eq('17:26')
          time_from_less_than_time_to(subject)
        }
      end

      context 'full range from high to low' do
        let(:user_tides) do
          t = FactoryBot.build(:conditions)
          t.tide.position_high_low = [3, -3]
          t.tide.position_low_high = [0, 0]
          t
        end
        subject { described_class.call(user_tides, forecast_tides) }

        it {
          expect(subject.times.count).to eq(2)
          expect(time_str(subject.times[0][:from])).to eq('5:06')
          expect(time_str(subject.times[0][:to])).to eq('11:07')
          time_from_less_than_time_to(subject)
        }
      end

      context 'full range from low to high' do
        let(:user_tides) do
          t = FactoryBot.build(:conditions)
          t.tide.position_high_low = [0, 0]
          t.tide.position_low_high = [3, -3]
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
          t = FactoryBot.build(:conditions)
          t.tide.position_high_low = [3, -3]
          t.tide.position_low_high = [3, -3]
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
          t = FactoryBot.build(:conditions)
          t.tide.position_high_low = [0, 0]
          t.tide.position_low_high = [0, 0]
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
        t = FactoryBot.build(:conditions)
        t.tide.position_high_low = [3, -3]
        t.tide.position_low_high = [0, 0]
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

  def find_first_of_tides(type)
    forecast_tides.tides.data.find { |t| t.type == type }
  end

end
