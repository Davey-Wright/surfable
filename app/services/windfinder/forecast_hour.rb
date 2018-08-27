module Windfinder
  class ForecastHour < ApplicationService
    attr_accessor :wave, :wind, :tide

    def initialize(hour)
      @wave = Wave.new(hour)
      @wind = Wind.new(hour)
      @tide = Tide.new(hour)
    end
  end
end


# Windfinder::ForecastHour
