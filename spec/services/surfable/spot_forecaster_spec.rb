require 'rails_helper'
require 'support/day_forecast_stub'

RSpec.describe Surfable::SpotForecaster do

  let(:spot) { FactoryBot.create(:spot_with_conditions) }

  subject {
    described_class.call(spot, forecast_day)
  }

  describe 'no surfable conditions' do
    let(:forecast_stub) { day_forecast_stub }
    let(:forecast_day) { Forecast::Day.new(forecast_stub) }

    context 'no surfable winds' do
      it { forecast_stub.hours.each { |hour| hour.wind[:speed] = 50 }
        expect(subject.forecast).to eq(nil) }
    end

    context 'no surfable swells' do
      it { forecast_stub.hours.each { |hour| hour.swell[:height] = 1 }
        expect(subject.forecast).to eq(nil) }
    end

    context 'with no tides' do
      it {
        spot.tide = nil
        expect(subject.forecast).to eq(nil)
      }
    end

    context 'with no wind conditions' do
      it {
        spot.winds = []
        expect(subject.forecast).to eq(nil)
      }
    end

    context 'with no swell conditions' do
      it {
        spot.swells = []
        expect(subject.forecast).to eq(nil)
      }
    end
  end

  describe 'surfable forecast' do
    let(:forecast_stub) { day_forecast_stub }
    let(:forecast_day) { Forecast::Day.new(forecast_stub) }

    context 'returns one set of forecast values' do
      context 'one tide, multiple wind and swell forecasts' do
        it { spot.tide.rising = []
          spot.tide.dropping = [1, 2, 3, 4, 5, 6]
          forecast_stub.hours[3].swell[:height] = 1
          forecast_stub.hours[5].wind[:speed] = 50
          expect(subject.forecast.length).to eq(1)
          expect(subject.forecast[0].rating).to eq(4.0)
          expect(time_start(0)).to eq('6:42')
          expect(time_end(0)).to eq('9:07') }
      end

      context 'one tide, wind forecast, multiple swell forecasts' do
        it { spot.tide.rising = [1, 2, 3, 4, 5, 6]
          spot.tide.dropping = []
          forecast_stub.hours[3].swell[:height] = 1
          expect(subject.forecast.length).to eq(1)
          expect(subject.forecast[0].rating).to eq(4.0)
          expect(time_start(0)).to eq('12:07')
          expect(time_end(0)).to eq('17:14') }
      end

      context 'multiple tide, swell, wind forecasts' do
        it { spot.tide.rising = [1, 2, 3]
          spot.tide.dropping = [3, 4, 5]
          forecast_stub.hours[4].swell[:height] = 1
          forecast_stub.hours[2].wind[:speed] = 50
          expect(subject.forecast.length).to eq(2)
          expect(subject.forecast[0].rating).to eq(4.0)
          expect(time_start(0)).to eq('11:07')
          expect(time_end(0)).to eq('12:07')
          expect(time_start(1)).to eq('9:06')
          expect(time_end(1)).to eq('10:06') }
      end

      context 'multiple tide, swell forecasts, one wind forecast' do
        it { spot.tide.rising = [1, 2, 3]
          spot.tide.dropping = [3, 4, 5]
          forecast_stub.hours[3].swell[:height] = 1
          subject
          expect(subject.forecast.length).to eq(2)
          expect(subject.forecast[0].rating).to eq(4.0)
          expect(time_start(1)).to eq('12:07')
          expect(time_end(1)).to eq('14:07')
          expect(time_start(0)).to eq('7:06')
          expect(time_end(0)).to eq('9:06') }
      end

      context 'multiple tide, wind forecasts, one swell forecast' do
        it { spot.tide.rising = [1, 2, 3]
          spot.tide.dropping = [3, 4, 5]
          forecast_stub.hours[2].wind[:speed] = 50
          expect(subject.forecast.length).to eq(2)
          expect(subject.forecast[0].rating).to eq(4.0)
          expect(time_start(0)).to eq('11:07')
          expect(time_end(0)).to eq('14:07')
          expect(time_start(1)).to eq('9:06')
          expect(time_end(1)).to eq('10:06') }
      end
    end

    context 'returns two sets of forecast values' do
      it { spot.tide.rising = [1, 2, 3, 4, 5, 6]
        spot.tide.dropping = []
        forecast_stub.hours[4].wind[:speed] = 50
        expect(subject.forecast.length).to eq(2)
        expect(subject.forecast.first.values.length).to eq(2)
        expect(subject.forecast[0].rating).to eq(4.0)
        expect(time_start(0)).to eq('11:07')
        expect(time_end(0)).to eq('12:14')
        expect(time_start(1)).to eq('15:07')
        expect(time_end(1)).to eq('17:14')
      }
    end

    context 'rating is an average of swell and wind ratings' do
      it { spot.tide.rising = [1, 2, 3, 4, 5, 6]
        spot.tide.dropping = []
        forecast_stub.hours[4].wind[:speed] = 50
        swell_rating = spot.swells.max_by { |i| i.rating }.rating
        wind_rating = spot.winds.max_by { |i| i.rating }.rating
        rating = (swell_rating + wind_rating) / 2
        expect(subject.forecast[0].rating).to eq(4.0)
      }
    end

    # context 'returns two sets of forecast values' do
    #   it { spot.tide.rising = [1, 2, 3, 4, 5, 6]
    #     spot.tide.dropping = []
    #     forecast_stub.hours[4].wind[:speed] = 50
    #     forecast_stub.hours[5].swell[:height] = 1
    #     expect(subject.forecast.length).to eq(2)
    #     expect(subject.forecast.first.values.length).to eq(2)
    #     expect(time_start(0)).to eq('11:07')
    #     expect(time_end(0)).to eq('12:14')
    #     expect(time_start(1)).to eq('15:07')
    #     expect(time_end(1)).to eq('17:14')
    #   }
    # end

    # test for ratings!!
  end

  def time_start(i)
    time_str subject.forecast[i].values.min
  end

  def time_end(i)
    time_str subject.forecast[i].values.max
  end

  def time_str(t)
    t.strftime("%k:%M").strip
  end

end
