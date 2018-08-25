require 'mechanize'

module WindfinderForecasts
  class ShortTermForecast < ApplicationService
    attr_accessor :days, :forecast_days

    def initialize(forecast_days)
      @forecast_days = forecast_days
      @days = get_days
    end

    def get_days
      forecast_days.map { |day| ForecastDay.new(day) }
    end
  end
end

# WindfinderForecasts::ShortTerm
