require 'rails_helper'
require 'support/day_forecast_stub'

RSpec.describe Surfable::Windows do

  let(:forecast_day) { Forecast::Day.new(day_forecast_stub) }
  let(:spot) { FactoryBot.create(:spot_with_conditions) }

  subject { described_class.call(spot, forecast) }

  describe do
    it { subject }
  end

  describe 'surfable window times' do
    context 'no offset times' do
      it {
        spot.tide.rising = []
        spot.tide.dropping = []
        expect(subject.times.count).to eq(0)
      }
    end

    context 'consecutive offset times' do
      it {
        subject.tide.rising = [0, 1, 2, 3]
        subject.tide.dropping = [3, 4, 5]
        expect(subject.times.count).to eq(2)
        expect(subject.times[0][:from]).to eq('11:06')
        expect(subject.times[0][:to]).to eq('15:06')
        expect(subject.times[1][:from]).to eq('8:06')
        expect(subject.times[1][:to]).to eq('11:06')
      }
    end

    context 'scattered offset times' do
      it {
        subject.tide.rising = [0, 5]
        subject.tide.dropping = [1, 4]
        expect(subject.times.count).to eq(4)
        expect(subject.times[0][:from]).to eq('11:06')
        expect(subject.times[0][:to]).to eq('12:06')
        expect(subject.times[1][:from]).to eq('16:04')
        expect(subject.times[1][:to]).to eq('17:04')
        expect(subject.times[2][:from]).to eq('6:52')
        expect(subject.times[2][:to]).to eq('7:06')
        expect(subject.times[3][:from]).to eq('9:06')
        expect(subject.times[3][:to]).to eq('10:06')
      }
    end
  end

  describe 'Reports' do

  end

  # describe 'reports attribute' do
  #   it {
  #     expect(subject.reports.count).to eq(subject.times.count)
  #     expect(subject.reports[0].count).to eq(subject.times[0][:to].hour - subject.times[0][:from].hour + 1)
  #     expect(subject.reports[1].count).to eq(subject.times[1][:to].hour - subject.times[1][:from].hour + 1)
  #   }
  # end

  def t(str)
    Time.parse(str)
  end

  def time_str(t)
    t.strftime("%k:%M").strip
  end

end
