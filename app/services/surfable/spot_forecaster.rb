module Surfable
  class SpotForecaster < ApplicationService

    attr_accessor :spot, :surfable, :times

    def initialize(spot, day)
      @spot = spot
      @day = day
      @surfable
      @times
    end

    def call

    end

    def tides_forecast
      @times = Matchers::Tides.call(spot, day).times
    end

    # def swells_forecast
    #   @times = Matchers::Swells.call(spot, day).times
    # end

    # def winds_forecast
    #   @times = Matchers::Winds.call(spot, day).times
    # end


    def spots_forecast(day)
      @spots.map do |spot|
        spot_forecast = Surfable::SpotForecast.new(spot, day).tides_forecast
        # spot_forecast.times = Matchers::Tides.call(spot, day).times
        # spot_forecast = surfable_conditions(spot_forecast, day)
        spot_forecast
      end
    end

    def surfable_conditions(spot_forecast, day)
      spot_forecast.times.each_with_index do |t, i|

        spot_forecast_hours = [*t.values.first.hour..t.values.last.hour]

        rating = []
        new_forecast_hours = []
        winds = spot_forecast.spot.winds.sort.sort_by{ |w| w.rating }.reverse!
        swells = spot_forecast.spot.swells.sort.sort_by{ |w| w.rating }.reverse!

        # REFACTOR - new method or class?
        spot_forecast_hours.each do |hour|

          surf_forecast_hour = get_surf_forecast_hour(day, hour)

          winds.each do |wind|
            if wind_matcher(wind, hour, surf_forecast_hour)
              rating.push wind.rating
              new_forecast_hours.push hour
              break
            end
          end

          swells.each do |swell|
            if swell_matcher(swell, hour, surf_forecast_hour)
              rating.push swell.rating
              new_forecast_hours.push hour
              break
            end
          end

        end

        spot_forecast.times[i].rating = rating.inject(:+) / rating.size.to_f

        if spot_forecast_hours.sort != new_forecast_hours.sort ||
          spot_forecast_hours.sort.first == new_forecast_hours.sort.first &&
          spot_forecast_hours.sort.last == new_forecast_hours.sort.last
            spot_forecast.times[i].values = spot_times(t.values, spot_forecast_hours, new_forecast_hours)
        end

      end
      return spot_forecast
    end

    def get_surf_forecast_hour(day, spot_forecast_hour)
      day.hours.select do |h|
        (h.value.hour..h.value.hour + 2) === spot_forecast_hour
      end.first
    end

    def spot_times(t, spot_times_arr, new_times_arr)
      s = new_times_arr.first - spot_times_arr.first
      f = new_times_arr.last - spot_times_arr.last
      [t.first + s.hours, t.last + f.hours]
    end

  end
end
