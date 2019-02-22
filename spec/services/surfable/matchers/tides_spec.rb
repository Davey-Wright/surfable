require 'rails_helper'
require 'support/day_forecast_stub'

RSpec.describe Surfable::Matchers::Tides do
  let(:forecast_day) { Forecast::Day.new(day_forecast_stub) }
  let(:spot) { FactoryBot.create(:spot_with_conditions) }

  subject { described_class.call(spot, forecast_day) }

  describe 'Times' do
    context 'with no matching user and forecast tide sizes' do
      it {
        spot.tide.rising = [1, 2, 3, 4]
        spot.tide.dropping = [3, 4, 5]
        spot.tide.size = [7, 8]
        expect(subject.forecast.length).to eq(0)
      }
    end

    context 'with matching user and forecast tide sizes,' do
      describe 'full range' do
        it {
          spot.tide.rising = [1, 2, 3, 4, 5, 6]
          spot.tide.dropping = [1, 2, 3, 4, 5, 6]
          expect(subject.forecast.length).to eq(1)
          expect(time_start(0)).to eq('6:42')
          expect(time_end(0)).to eq('17:14')
        }
      end

      describe 'no range offsets' do
        it {
          spot.tide.rising = []
          spot.tide.dropping = []
          expect(subject.forecast.length).to eq(0)
        }
      end

      describe 'full range for rising tide' do
        it {
          spot.tide.rising = [1, 2, 3, 4, 5, 6]
          spot.tide.dropping = []
          expect(subject.forecast.length).to eq(1)
          expect(time_start(0)).to eq('11:07')
          expect(time_end(0)).to eq('17:14')
        }
      end

      describe 'full range for dropping tide' do
        it {
          spot.tide.rising = []
          spot.tide.dropping = [1, 2, 3, 4, 5, 6]
          expect(subject.forecast.length).to eq(1)
          expect(time_start(0)).to eq('6:42')
          expect(time_end(0)).to eq('11:07')
        }
      end

      describe 'with consecutive offsets times' do
        it {
          spot.tide.rising = [1, 2, 3]
          spot.tide.dropping = [3, 4, 5]
          expect(subject.forecast.length).to eq(2)
          expect(time_start(0)).to eq('11:07')
          expect(time_end(0)).to eq('14:07')
          expect(time_start(1)).to eq('7:06')
          expect(time_end(1)).to eq('10:06')
        }
      end

      describe 'scattered offsets times' do
        it {
          spot.tide.rising = [2, 5]
          spot.tide.dropping = [3, 5]
          expect(subject.forecast.length).to eq(4)
          expect(time_start(0)).to eq('12:07')
          expect(time_end(0)).to eq('13:07')
          expect(time_start(1)).to eq('15:07')
          expect(time_end(1)).to eq('16:07')
          expect(time_start(2)).to eq('7:06')
          expect(time_end(2)).to eq('8:06')
          expect(time_start(3)).to eq('9:06')
          expect(time_end(3)).to eq('10:06')
        }
      end

      describe 'single offset times' do
        it {
          spot.tide.rising = [3]
          spot.tide.dropping = [3]
          expect(subject.forecast.length).to eq(2)
          expect(time_start(0)).to eq('13:07')
          expect(time_end(0)).to eq('14:07')
          expect(time_start(1)).to eq('7:06')
          expect(time_end(1)).to eq('8:06')
        }
      end

      describe 'first and last hour offsets' do
        it {
          spot.tide.rising = [1, 6]
          spot.tide.dropping = [1, 6]
          expect(subject.forecast.length).to eq(3)
          expect(time_start(0)).to eq('11:07')
          expect(time_end(0)).to eq('12:07')
          expect(time_start(1)).to eq('16:07')
          expect(time_end(1)).to eq('17:14')
          expect(time_start(2)).to eq('10:06')
          expect(time_end(2)).to eq('11:07')
        }
      end
    end
  end

  def time_start(index)
    time_str subject.forecast[index].values.min
  end

  def time_end(index)
    time_str subject.forecast[index].values.max
  end

  def time_str(time)
    time.strftime('%k:%M').strip
  end
end
