module Surfable
  class SpotForecaster < ApplicationService

    attr_accessor :spot, :forecast

    def initialize(spot, day)
      @spot = spot
      @day = day
      @forecast
    end

    def call
      @forecast = Matchers::Tides.call(spot, @day).forecast
      swell_forecast = Matchers::Swells.call(spot, @day).forecast
      wind_forecast = Matchers::Winds.call(spot, @day).forecast
      return nil if swell_forecast.blank? || wind_forecast.blank?
      swell_forecast.each { |c| surfable_forecast(c) }
      wind_forecast.each { |c| surfable_forecast(c) }
      self
    end

    private

      def surfable_forecast(c)
        @forecast.each_with_index do |f, i|
          return if f.values.blank?

          c_hours = []
          c.each { |c| c_hours.push *c[:hour]..c[:hour]+2 }

          f_hours = [*f.values.first.hour..f.values.last.hour]
          next if f_hours.length == c_hours.length

          new_hours = f_hours & c_hours
          return [] if new_hours.blank?

          @forecast[i].rating = nil
          @forecast[i].values = set_forecast_values(new_hours, f.values)
        end
      end

      def set_forecast_values(new_hours, forecast)
        start = forecast.min + (new_hours.min - forecast.min.hour).hours
        finish = if new_hours.max == forecast.max.hour
          forecast.max
        else
          diff = (new_hours.max - forecast.max.hour)
          forecast.max + diff.hours + 1.hours
        end
        return [start, finish]
      end

  end
end
