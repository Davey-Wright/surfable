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
        expect(subject.times[:rising].count).to eq(0)
        expect(subject.times[:dropping].count).to eq(0)
      }
    end

    context 'with matching user and forecast tide sizes,' do
      describe 'full range' do
        it {
          spot.tide.rising = [1, 2, 3, 4, 5, 6]
          spot.tide.dropping = [1, 2, 3, 4, 5, 6]
          expect(subject.times[:rising].count).to eq(3)
          expect(subject.times[:dropping].count).to eq(2)
          expect(rising_times_start(0)).to eq('0:00')
          expect(rising_times_end(0)).to eq('5:06')
          expect(rising_times_start(1)).to eq('11:07')
          expect(rising_times_end(1)).to eq('17:26')
          expect(rising_times_start(2)).to eq('23:32')
          expect(rising_times_end(2)).to eq('23:59')

          expect(dropping_times_start(0)).to eq('5:06')
          expect(dropping_times_end(0)).to eq('11:07')
          expect(dropping_times_start(1)).to eq('17:26')
          expect(dropping_times_end(1)).to eq('23:32')
        }
      end

      describe 'no range offsets' do
        it {
          spot.tide.rising = []
          spot.tide.dropping = []
          expect(subject.times[:rising].count).to eq(0)
          expect(subject.times[:dropping].count).to eq(0)
        }
      end

      describe 'full range for rising tide' do
        it {
          spot.tide.rising = [1, 2, 3, 4, 5, 6]
          spot.tide.dropping = []
          expect(subject.times[:rising].count).to eq(3)
          expect(rising_times_start(0)).to eq('0:00')
          expect(rising_times_end(0)).to eq('5:06')
          expect(rising_times_start(1)).to eq('11:07')
          expect(rising_times_end(1)).to eq('17:26')
          expect(rising_times_start(2)).to eq('23:32')
          expect(rising_times_end(2)).to eq('23:59')
        }
      end

      describe 'full range for dropping tide' do
        it {
          spot.tide.rising = []
          spot.tide.dropping = [1, 2, 3, 4, 5, 6]
          expect(subject.times[:dropping].count).to eq(2)
          expect(dropping_times_start(0)).to eq('5:06')
          expect(dropping_times_end(0)).to eq('11:07')
          expect(dropping_times_start(1)).to eq('17:26')
          expect(dropping_times_end(1)).to eq('23:32')
        }
      end

      describe 'with consecutive offsets times' do
        it {
          spot.tide.rising = [1, 2, 3]
          spot.tide.dropping = [3, 4, 5]
          expect(subject.times[:rising].count).to eq(3)
          expect(subject.times[:dropping].count).to eq(2)
          expect(rising_times_start(0)).to eq('0:00')
          expect(rising_times_end(0)).to eq('2:06')
          expect(rising_times_start(1)).to eq('11:07')
          expect(rising_times_end(1)).to eq('14:07')
          expect(rising_times_start(2)).to eq('23:32')
          expect(rising_times_end(2)).to eq('23:59')

          expect(dropping_times_start(0)).to eq('7:06')
          expect(dropping_times_end(0)).to eq('10:06')
          expect(dropping_times_start(1)).to eq('19:26')
          expect(dropping_times_end(1)).to eq('22:26')
        }
      end

      describe 'scattered offsets times' do
        it {
          spot.tide.rising = [1, 6]
          spot.tide.dropping = [1, 4]
          expect(subject.times[:rising].count).to eq(5)
          expect(subject.times[:dropping].count).to eq(4)
          expect(rising_times_start(0)).to eq('0:00')
          expect(rising_times_end(0)).to eq('0:06')
          expect(rising_times_start(1)).to eq('4:06')
          expect(rising_times_end(1)).to eq('5:06')
          expect(rising_times_start(2)).to eq('11:07')
          expect(rising_times_end(2)).to eq('12:07')
          expect(rising_times_start(3)).to eq('16:07')
          expect(rising_times_end(3)).to eq('17:26')
          expect(rising_times_start(4)).to eq('23:32')
          expect(rising_times_end(4)).to eq('23:59')

          expect(dropping_times_start(0)).to eq('5:06')
          expect(dropping_times_end(0)).to eq('6:06')
          expect(dropping_times_start(1)).to eq('8:06')
          expect(dropping_times_end(1)).to eq('9:06')
          expect(dropping_times_start(2)).to eq('17:26')
          expect(dropping_times_end(2)).to eq('18:26')
          expect(dropping_times_start(3)).to eq('20:26')
          expect(dropping_times_end(3)).to eq('21:26')

        }
      end
    end
  end

  def rising_times_start(i)
    time_str subject.times[:rising][i].min
  end

  def rising_times_end(i)
    time_str subject.times[:rising][i].max
  end

  def dropping_times_start(i)
    time_str subject.times[:dropping][i].min
  end

  def dropping_times_end(i)
    time_str subject.times[:dropping][i].max
  end

  def time_str(t)
    t.strftime("%k:%M").strip
  end

end
