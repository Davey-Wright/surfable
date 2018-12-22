module Surfable
  class Windows < ApplicationService
    attr_reader :times, :reports

    def initialize(spot, forecast_day)
      @spot = spot
      @forecast_day = forecast_day
      @times = set_times
      @reports = []
    end

    def call
      @times.each do |time|
        hours = select_forecast_hours(time)
        @reports.push create_report(time, hours)
      end
      self
    end

    private

      def set_times
        tide_times = Matchers::Tides.call(spot, forecast_day).times
        Matchers::Daylight.call(tide_times, forecast_day).times
      end

      def create_report(time, hours)
        (time[:from].hour..time[:to].hour).map do |time|
          forecast = hours.select { |h| (h.value.hour..h.value.hour + 2) === time }.first
          Matchers::Conditions.call(time, forecast, @spot)
        end
      end

      def select_forecast_hours(t)
        @forecast_day.hours.select do |h|
          v = (h.value.hour..h.value.hour + 2)
          h if v === t[:from].hour || v === t[:to].hour
        end
      end
  end
end
