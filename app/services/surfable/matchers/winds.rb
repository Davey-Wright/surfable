module Surfable
  module Matchers
    class Winds < ApplicationService

      attr_reader :forecast, :times

      def initialize(spot, day)
        @spot = spot
        @day = day
        @winds = spot.winds.sort.sort_by{ |w| w.rating }.reverse!
        @forecast = []
      end

      def call
        @day.hours.each do |hour|
          @winds.each do |wind|
            if matcher(wind, hour.wind)
              @forecast.push ({ hour: hour.value, rating: wind.rating })
              break
            end
          end
        end
        self
      end

      private

       def matcher(wind, forecast)
         return false if wind.speed < forecast.average_speed
         return false unless wind.direction.include? forecast_direction(forecast.direction)
         return true
       end

       def forecast_direction(d)
         direction = case d
           when (0..22) || (337..360)
             'n'
           when 23..68
             'ne'
           when 69..112
             'e'
           when 113..157
             'se'
           when 158..202
             's'
           when 203..247
             'sw'
           when 248..292
             'w'
           when 293..337
             'nw'
         end
         direction
       end

    end
  end
end
