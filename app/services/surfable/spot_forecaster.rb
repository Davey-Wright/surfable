module Surfable
  class SpotForecaster < ApplicationService
    attr_reader :forecast, :spot

    def initialize(spot, day)
      @spot = spot
      @day = day
    end

    def call
      new_forecast = match_tide_forecast
      new_forecast = match_swell_forecast(new_forecast) unless new_forecast.nil?
      new_forecast = match_wind_forecast(new_forecast) unless new_forecast.nil?
      @forecast = new_forecast
      self
    end

    private

    def match_tide_forecast
      return nil if @spot.tide.nil?
      tide = Matchers::Tides.call(@spot, @day).forecast
      tide.blank? ? nil : tide
    end

    def match_swell_forecast(forecast)
      swells = Matchers::Swells.call(@spot, @day).forecast
      return nil if swells.blank?
      new_forecast = []
      swells.each do |swell|
        sf = surfable_forecast(swell, forecast)
        new_forecast.push sf unless sf.nil?
      end
      new_forecast.flatten!
    end

    def match_wind_forecast(forecast)
      winds = Matchers::Winds.call(@spot, @day).forecast
      return nil if winds.blank?
      new_forecast = []
      winds.each do |wind|
        sf = surfable_forecast(wind, forecast)
        new_forecast.push sf unless sf.nil?
      end
      new_forecast.flatten!
    end

    def surfable_forecast(conditions, new_forecast)
      a = []
      new_forecast.each do |f|
        next if f.values.blank?
        c_hours = []
        conditions.each { |c| c_hours.push(*c[:hour]..c[:hour] + 2) }
        f_hours = [*f.values.first.hour..f.values.last.hour]
        new_hours = f_hours & c_hours
        next if new_hours.blank?
        rating = set_forecast_rating(conditions, new_hours)
        rating = (rating + f.rating) / 2 unless f.rating.nil?
        a.push set_new_forecast(f, new_hours, rating)
      end
      a
    end

    def set_new_forecast(forecast, hours, rating)
      new_forecast = Marshal.load(Marshal.dump(forecast))
      new_forecast.rating = rating
      new_forecast.values = set_forecast_values(hours, new_forecast.values)
      new_forecast
    end

    def set_forecast_rating(conditions, new_forecast)
      rating = conditions.map do |h|
        h[:rating] if (new_forecast & [*h[:hour]..h[:hour] + 2]).present?
      end
      rating.compact!
      return rating.inject(:+).to_i / rating.size unless rating.nil?
    end

    def set_forecast_values(new_hours, forecast)
      start = forecast.min + (new_hours.min - forecast.min.hour).hours
      finish =
        if new_hours.max == forecast.max.hour
          forecast.max
        else
          diff = (new_hours.max - forecast.max.hour)
          forecast.max + diff.hours + 1.hours
        end
      [start, finish]
    end
  end
end
