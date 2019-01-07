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
          @swells.each do |condition|
            if matcher(condition, hour.swell)
              @forecast.push ({ hour: hour, rating: condition.rating })
              break
            end
          end
        end
        self
      end

      private

       def matcher(condition, forecast)
         if condition.max_height != nil
           return false if condition.max_height < forecast.height
         end
         return false if condition.min_height > forecast.height
         return false if condition.min_period > forecast.period
         return false unless condition.direction.include? forecast_direction(forecast.direction)
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
