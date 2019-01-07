module Surfable
  class Windows < ApplicationService
    attr_reader :times, :reports

    def initialize(spot, forecast_day)
      @spot = spot
      @forecast_day = forecast_day
      @times = Matchers::Tides.call(spot, forecast_day).times
      @reports = []
    end

    def call
      rising_tide_report
      dropping_tide_report
      self
    end

    private

      def rising_tide_report
        @times[:rising].each do |time|
          hours = filter_forecast_hours(time)
          report = create_report(time, hours)
        end
      end

      def dropping_tide_report
        @times[:dropping].each do |time|
          hours = filter_forecast_hours(time)
          report = create_report(time, hours)
        end
      end

      def create_report(time, hours)
        (time.first.hour..time.last.hour).map do |window_hour|
          forecast_hour = hours.select do
            |h| (h.value.hour..h.value.hour + 2) === window_hour
          end.first
          Matchers::Conditions.call(window_hour, forecast_hour, @spot)
        end
      end

      def filter_forecast_hours(time)
        @forecast_day.hours.select do |h|
          v = (h.value.hour..h.value.hour + 2)
          h if v === time.first.hour || v === time.last.hour
        end
      end

      # def relevant_hours(spot_forecast, forecast_day)
      #   spot_forecast.times.map do |time|
      #     forecast_day.hours.select do |h|
      #       v = (h.value.hour..h.value.hour + 2)
      #       h if v === time.values.first.hour || v === time.values.last.hour
      #     end
      #   end
      # end
  end
end
