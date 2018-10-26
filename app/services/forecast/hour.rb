module Forecast
  class Hour
    attr_reader :day, :swell, :wind, :tide, :value, :data

    def initialize(day, data)
      @day = day
      @data = data
      @value = Time.at(data['localTimestamp']).hour - 1
      @swell = Swell.new(self, data)
      @wind = Wind.new(self, data)
    end
  end
end
