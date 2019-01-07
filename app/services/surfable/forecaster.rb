module Surfable
  class Forecaster < ApplicationService

    attr_reader :forecast, :times

    def initialize(spots, surf_forecast)
      @spots = [*spots]
      @surf_forecast = [*surf_forecast]
      @forecast = []
      @times
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
        @spots.map do |spot|
          spot_forecast = Surfable::SpotForecast.new(spot, day).tides_forecast
        end
      end

  end
end
