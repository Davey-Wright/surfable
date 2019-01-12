module Surfable
  class SpotForecaster < ApplicationService

    attr_reader :forecast

    def initialize(spot, day)
      @spot = spot
      @day = day
      @forecast
    end

    def call
      new_forecast = match_tide_forecast
      new_forecast = match_swell_forecast(new_forecast) if new_forecast != nil
      new_forecast = match_wind_forecast(new_forecast) if new_forecast != nil
      @forecast = new_forecast
      self
    end

    private

      def match_tide_forecast
        return nil if @spot.tide.nil?
        tide = Matchers::Tides.call(@spot, @day).forecast
        tide.blank? ? nil : tide
      end

      def match_swell_forecast(f)
        swells = Matchers::Swells.call(@spot, @day).forecast
        return nil if swells.blank?
        new_forecast = []
        swells.each do |s|
          x = surfable_forecast(s, f)
          new_forecast.push x unless x.nil?
        end
        return new_forecast.flatten!
      end

      def match_wind_forecast(f)
        winds = Matchers::Winds.call(@spot, @day).forecast
        return nil if winds.blank?
        new_forecast = []
        winds.each do |s|
          x = surfable_forecast(s, f)
          new_forecast.push x unless x.nil?
        end
        return new_forecast.flatten!
      end

      def surfable_forecast(c, new_forecast)
        a = []
        new_forecast.each do |f|
          return if f.values.blank?
          c_hours = []
          c.each { |c| c_hours.push *c[:hour]..c[:hour]+2 }
          f_hours = [*f.values.first.hour..f.values.last.hour]
          new_hours = f_hours & c_hours
          next if new_hours.blank?
          rating = set_forecast_rating(c, new_hours)
          rating = (rating + f.rating) / 2 unless f.rating.nil?
          a.push set_new_forecast(f, new_hours, rating)
        end
        return a
      end

      def set_new_forecast(f, h, r)
        new_forecast = Marshal.load(Marshal.dump(f))
        new_forecast.rating = r
        new_forecast.values = set_forecast_values(h, new_forecast.values)
        return new_forecast
      end

      def set_forecast_rating(c, n)
        rating = c.map do |h|
          h[:rating] if (n & [*h[:hour]..h[:hour]+2]).present?
        end
        return rating.compact!.inject(:+).to_f / rating.size
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
