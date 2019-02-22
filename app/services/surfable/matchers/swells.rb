module Surfable
  module Matchers
    class Swells < ApplicationService

      attr_reader :forecast, :times

      def initialize(spot, day)
        @spot = spot
        @day = day
        @swells = spot.swells.sort.sort_by{ |w| w.rating }.reverse!
        @forecast = []
      end

      def call
        @day.hours.each do |hour|
          @swells.each do |swell|
            if matcher(swell, hour.swell)
              @forecast.push ({ hour: hour.value.hour, rating: swell.rating })
              break
            end
          end
        end
        slice_forecast
        self
      end

      private

       def matcher(swell, forecast)
         if swell.max_height != nil
           return false if swell.max_height < forecast.height
         end
         return false if swell.min_height > forecast.height
         return false if swell.min_period > forecast.period
         return false unless swell.direction.include? forecast_direction(forecast.direction)
         return true
       end

       def slice_forecast
         @forecast = @forecast.slice_when do |prev, curr|
           prev[:hour] + 3 != curr[:hour]
         end.to_a
       end

       def forecast_direction(d)
         direction = case d
           when (0..22) || (337..360)
             'S'
           when 23..68
             'SW'
           when 69..112
             'W'
           when 113..157
             'NW'
           when 158..202
             'N'
           when 203..247
             'NE'
           when 248..292
             'E'
           when 293..337
             'SE'
         end
         direction
       end

    end
  end
end
