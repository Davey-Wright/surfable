module Surfable
  class Forecaster < ApplicationService

    attr_reader :forecast

    def initialize(spots, surf_forecast)
      @spots = [*spots]
      @surf_forecast = surf_forecast.days
      @forecast = []
    end

    def call
      @surf_forecast.each do |day|
        @forecast.push({
          date: day.date,
          spots: get_spots_forecast(day) })
      end
      self
    end

    private

      def get_spots_forecast(day)
        spot_forecast = []
        @spots.each do |spot|
          next if spot.tide.nil? || spot.swells.blank? || spot.winds.blank?
          surfable = Surfable::SpotForecaster.call(spot, day)
          spot_forecast.push surfable if !surfable.forecast.nil?
        end
        return spot_forecast
      end

  end
end
