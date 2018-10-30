module Forecast
  class Hour
    attr_reader :day, :swell, :wind, :tide, :value

    def initialize(day, data)
      @day = day
      @value = Time.at(data['localTimestamp']).hour - 1
      @swell = Swell.new(self, data)
      @wind = Wind.new(self, data)
    end
  end
end
