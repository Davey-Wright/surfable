module Surfable
  class Windows < ApplicationService
    attr_reader :times, :reports

    def initialize(spot_conditions, forecast_day)
      @spot_conditions = spot_conditions
      @forecast_day = forecast_day
      tide = Matchers::Tides.call(spot_conditions, forecast_day)
      @times = Matchers::Daylight.call(tide, forecast_day).times
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

      def create_report(time, hours)
        (time[:from].hour..time[:to].hour).map do |time|
          forecast = hours.select { |h| (h.value.hour..h.value.hour + 2) === time }.first
          Matchers::Conditions.call(time, forecast, @spot_conditions)
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
