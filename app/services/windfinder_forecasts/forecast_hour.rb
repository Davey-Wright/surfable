module WindfinderForecasts
  class ForecastHour < ApplicationService
    attr_accessor :value, :wave, :wind, :tide

    def initialize(hour)
      @value = hour
      @wave = Wave.new(hour)
      @wind = Wind.new(hour)
      @tide = Tide.new(hour)
    end
  end
end


# WindfinderForecasts::ForecastHour
