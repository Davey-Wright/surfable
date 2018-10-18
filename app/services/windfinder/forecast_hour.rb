module Windfinder
  class ForecastHour < ApplicationService
    attr_accessor :swell, :wind, :tide

    def initialize(hour)
      @swell = Swell.new(hour)
      @wind = Wind.new(hour)
      @tide = Tide.new(hour)
    end
  end
end


# Windfinder::ForecastHour
