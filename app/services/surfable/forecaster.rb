# surfable_times = {
#   :date,
#   spots: [{
#     :id,
#     :name,
#     :surfable,
#     times: [{
#       :rating,
#       :tide,
#       :values,
#       }]
#     }]
# }

module Surfable
  class Forecaster < ApplicationService

    attr_reader :forecast

    def initialize(spots, surf_forecast)
      @spots = [*spots]
      @surf_forecast = [*surf_forecast]
      @forecast = []
    end

    def call
      @surf_forecast.each do |forecast_day|
        @forecast.push({
          date: forecast_day.date,
          spots: spots_forecast(forecast_day) })
      end
      self
    end

    private

      def spot_struct
        Struct.new :id, :name, :surfable, :times
      end

      def spots_forecast(forecast_day)
        @spots.map do |spot|
          spot_forecast = spot_struct.new(spot.id, spot.name)
          spot_forecast.times = Matchers::Tides.call(spot, forecast_day).times
          forecast_hours = relevant_hours(spot_forecast, forecast_day)
          swell = Matchers::Swell.call(spot_forecast, forecast_hours)
          spot_forecast
        end
      end

      def relevant_hours(spot_forecast, forecast_day)
        spot_forecast.times.map do |time|
          forecast_day.hours.select do |h|
            v = (h.value.hour..h.value.hour + 2)
            h if v === time.values.first.hour || v === time.values.last.hour
          end
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
