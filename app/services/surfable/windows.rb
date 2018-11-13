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
        forecast_hours = select_forecast_hours(time)
        report = []
        (time[:from].hour..time[:to].hour).each do |hour|
          forecast = forecast_hours.select { |h| (h.value.hour..h.value.hour+2) === hour }.first
          report.push Matchers::Conditions.call(hour, forecast, @spot_conditions)
        end
        @reports.push report
      end
      self
    end

    private

      def select_forecast_hours(t)
        @forecast_day.hours.select do |h|
          v = (h.value.hour..h.value.hour + 2)
          h if v === t[:from].hour || v === t[:to].hour
        end
      end
  end
end
