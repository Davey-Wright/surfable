module Forecast
  class Day
    attr_reader :date, :hours, :tides, :sunrise, :sunset, :first_light, :last_light

    def initialize(data)
      @date = Time.parse(data.date)
      @hours = data.hours.map { |hour| Hour.new(self, hour) }
      @tides = Tide.new(self, data.tides)
      @first_light = Time.at(data.first_light)
      @sunrise = Time.at(data.sunrise)
      @sunset = Time.at(data.sunset)
      @last_light = Time.at(data.last_light)
    end
  end
end
