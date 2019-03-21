module Surfable
  module Matchers
    class Winds < ApplicationService
      attr_reader :forecast

      def initialize(spot, day)
        @spot = spot
        @day = day
        @winds = spot.winds.sort.sort_by(&:rating).reverse!
        @forecast = []
      end

      def call
        @day.hours.each do |hour|
          @winds.each do |wind|
            if matcher(wind, hour.wind)
              @forecast.push(hour: hour.value.hour, rating: wind.rating)
              break
            end
          end
        end
        slice_forecast
        self
      end

      private

      def matcher(wind, forecast)
        return false if wind.max_speed < forecast.average_speed
        return false unless wind.direction.include? forecast_direction(forecast.direction)
        true
      end

      def slice_forecast
        @forecast = @forecast.slice_when do |prev, curr|
          prev[:hour] + 3 != curr[:hour]
        end.to_a
      end

      def forecast_direction(dir)
        case dir
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
      end
    end
  end
end
