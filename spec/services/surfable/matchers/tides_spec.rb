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
        expect(subject.times.count).to eq(0)
      }
    end

    context 'with matching user and forecast tide sizes,' do
      describe 'full range' do
        it {
          spot.tide.rising = [1, 2, 3, 4, 5, 6]
          spot.tide.dropping = [1, 2, 3, 4, 5, 6]
          expect(subject.times.count).to eq(1)
          expect(time_str subject.times[0].min).to eq('0:00')
          expect(time_str subject.times[0].max).to eq('23:59')
        }
      end

      describe 'no range offsets' do
        it {
          spot.tide.rising = []
          spot.tide.dropping = []
          expect(subject.times.count).to eq(0)
        }
      end

      describe 'full range for rising tide' do
        it {
          spot.tide.rising = [1, 2, 3, 4, 5, 6]
          spot.tide.dropping = []
          expect(subject.times.count).to eq(3)
          expect(time_str subject.times[0].min).to eq('0:00')
          expect(time_str subject.times[0].max).to eq('5:06')
          expect(time_str subject.times[1].min).to eq('11:07')
          expect(time_str subject.times[1].max).to eq('17:26')
          expect(time_str subject.times[2].min).to eq('23:32')
          expect(time_str subject.times[2].max).to eq('23:59')
        }
      end

      describe 'full range for dropping tide' do
        it {
          spot.tide.rising = []
          spot.tide.dropping = [1, 2, 3, 4, 5, 6]
          expect(subject.times.count).to eq(2)
          expect(time_str subject.times[0].min).to eq('5:06')
          expect(time_str subject.times[0].max).to eq('11:07')
          expect(time_str subject.times[1].min).to eq('17:26')
          expect(time_str subject.times[1].max).to eq('23:32')
        }
      end

      describe 'with consecutive offsets times' do
        it {
          spot.tide.rising = [1, 2, 3]
          spot.tide.dropping = [3, 4, 5]
          expect(subject.times.count).to eq(5)
          expect(time_str subject.times[0].min).to eq('0:00')
          expect(time_str subject.times[0].max).to eq('2:06')
          expect(time_str subject.times[1].min).to eq('11:07')
          expect(time_str subject.times[1].max).to eq('14:07')
          expect(time_str subject.times[2].min).to eq('23:32')
          expect(time_str subject.times[2].max).to eq('23:59')
          expect(time_str subject.times[3].min).to eq('7:06')
          expect(time_str subject.times[3].max).to eq('10:06')
          expect(time_str subject.times[4].min).to eq('19:26')
          expect(time_str subject.times[4].max).to eq('22:26')
        }
      end

      describe 'scattered offsets times' do
        it {
          spot.tide.rising = [1, 6]
          spot.tide.dropping = [1, 4]
          expect(subject.times.count).to eq(9)
          expect(time_str subject.times[0].min).to eq('0:00')
          expect(time_str subject.times[0].max).to eq('0:06')
          expect(time_str subject.times[1].min).to eq('4:06')
          expect(time_str subject.times[1].max).to eq('5:06')
          expect(time_str subject.times[2].min).to eq('11:07')
          expect(time_str subject.times[2].max).to eq('12:07')
          expect(time_str subject.times[3].min).to eq('16:07')
          expect(time_str subject.times[3].max).to eq('17:26')
          expect(time_str subject.times[4].min).to eq('23:32')
          expect(time_str subject.times[4].max).to eq('23:59')

          expect(time_str subject.times[5].min).to eq('5:06')
          expect(time_str subject.times[5].max).to eq('6:06')
          expect(time_str subject.times[6].min).to eq('8:06')
          expect(time_str subject.times[6].max).to eq('9:06')
          expect(time_str subject.times[7].min).to eq('17:26')
          expect(time_str subject.times[7].max).to eq('18:26')
          expect(time_str subject.times[8].min).to eq('20:26')
          expect(time_str subject.times[8].max).to eq('21:26')

        }
      end
    end
  end

  def time_from_less_than_time_to(s)
    subject.times.each do |time|
      expect(time.min < time.max).to eq(true)
    end
  end

  def time_str(t)
    t.strftime("%k:%M").strip
  end

end
