module Forecast
  class Day
    attr_reader :date, :hours, :tides, :sunrise, :sunset, :first_light, :last_light

    def initialize(data)
      @date = data.date
      @hours = data.hours.map{ |hour| Hour.new(self, hour) }
      @tides = Tide.new(self, data.tides)
      @first_light = data.first_light
      @sunrise = data.sunrise
      @sunset = data.sunset
      @last_light = data.last_light
    end
  end
end
