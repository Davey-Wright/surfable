module Windfinder
  class ForecastHour < ApplicationService
    attr_accessor :swell, :wind, :tide, :surfable, :forecast_day

    def initialize(hour)
      @swell = Swell.new(hour)
      @wind = Wind.new(hour)
      @tide = Tide.new(hour)
      @surfable = false
    end
  end
end
