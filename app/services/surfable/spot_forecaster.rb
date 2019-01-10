module Surfable
  class SpotForecaster < ApplicationService

    attr_accessor :spot, :forecast, :new_forecast

    def initialize(spot, day)
      @spot = spot
      @day = day
      @forecast = []
      @new_forecast
    end

    def call
      shaka = Matchers::Tides.call(spot, @day).forecast
      swell_forecast = Matchers::Swells.call(spot, @day).forecast
      wind_forecast = Matchers::Winds.call(spot, @day).forecast
      return nil if swell_forecast.blank? || wind_forecast.blank?
      
      swell_forecast.each { |c| surfable_forecast(c, new_forecast) }
      wind_forecast.each { |c| surfable_forecast(c, shaka) }
      self
    end

    private

      def surfable_forecast(c)
        shaka.each do |f, i|
          return if f.values.blank?

          c_hours = []
          c.each { |c| c_hours.push *c[:hour]..c[:hour]+2 }

          f_hours = [*f.values.first.hour..f.values.last.hour]
          next if f_hours.length == c_hours.length

          new_hours = f_hours & c_hours
          return [] if new_hours.blank?

          push_forecast(f)
        end
      end

      def push_forecast(f)
        new_forecast = Marshal.load(Marshal.dump(f))
        new_forecast.rating = nil
        new_forecast.values = set_forecast_values(new_hours, nf.values)
        @forecast.push new_forecast
      end

      def set_forecast_values(new_hours, f)
        start = f.min + (new_hours.min - f.min.hour).hours
        finish = if new_hours.max == f.max.hour
          f.max
        else
          diff = (new_hours.max - f.max.hour)
          f.max + diff.hours + 1.hours
        end
        return [start, finish]
      end

  end
end
