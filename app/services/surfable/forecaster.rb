surfable_times = {
  :date,
  spots: [{
    :id,
    :name,
    times: [{
      :rating,
      :tide,
      values: []
      }]
    }]
}

module Surfable
  class Forecaster < ApplicationService

    attr_reader :shaka

    def initialize(spots, surf_forecast)
      @spots = [*spots]
      @surf_forecast = [*surf_forecast]
      @forecast = []
    end

    def call
      @forecast = @surf_forecast.map do |day|
        { date: day.date, spots: spots_forecast(day) }
      end
    end

    private

      def spot_struct
        Struct.new :id, :name, :rating, :times
      end

      def spots_forecast(day)
        @spots.map do |spot|
          surfable_tides = Matchers::Tides.call(spot, day)
          relavent_forecast = surfable_tides.each do |tide|
          end
          spot_struct.new(spot.id, spot.name)
        end
      end

      def match_tides
      end

      def match_winds
      end

      def match_swells
      end

      def match_conditions
      end

      def rising_tide_report
        @times[:rising].each do |time|
          hours = filter_forecast_hours(time)
        end
      end

      def dropping_tide_report
        @times[:dropping].each do |time|
          hours = filter_forecast_hours(time)
        end
      end

      def filter_forecast_hours(day, time)
        day.hours.select do |h|
          v = (h.value.hour..h.value.hour + 2)
          h if v === time.first.hour || v === time.last.hour
        end
      end

      def create_report(surfable_tides, hours)
        (surfable_tides.first.hour..surfable_tides.last.hour).map do |hour|
          forecast_hour = hours.select do
            |h| (h.value.hour..h.value.hour + 2) === tide_hour
          end.first
          Matchers::Conditions.call(hour, forecast_hour, @spot)
        end
      end

  end
end
