module Windfinder
  class ForecastHour
    attr_reader :day, :swell, :wind, :tide, :value

    def initialize(day, hour)
      @day = day
      @value = hour.css('.cell-timespan .value').text.to_i
      @swell = Swell.new(self, hour)
      @wind = Wind.new(self, hour)
      @tide = Tide.new(self, hour)
    end
  end
end
