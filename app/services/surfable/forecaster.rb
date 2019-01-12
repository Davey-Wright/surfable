module Surfable
  class Forecaster < ApplicationService

    attr_reader :forecast

    def initialize(spots, surf_forecast)
      @spots = [*spots]
      @surf_forecast = [*surf_forecast]
      @forecast = []
    end

    def call
      @surf_forecast.each do |day|
        @forecast.push({
          date: day.date,
          spots: spots_forecast(day) })
      end
      self
    end

    private

      def spots_forecast(day)
        spot_forecast = []
        @spots.each do |spot|
          unless spot.tide.nil? || spot.swells.blank? || spot.winds.blank?
            spot_forecast.push Surfable::SpotForecaster.call(spot, day)
          end
        end
        return spot_forecast
      end

  end
end
