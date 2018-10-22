module Windfinder
  class ForecastHour < ApplicationService
    attr_accessor :day, :swell, :wind, :tide, :surfable, :forecast_day

    def initialize(day, hour)
      @day = day
      @swell = Swell.new(hour)
      @wind = Wind.new(hour)
      @tide = Tide.new(hour)
      @surfable = false
    end
  end
end
