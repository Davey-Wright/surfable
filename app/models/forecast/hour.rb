module Forecast
  class Hour
    attr_reader :day, :value, :swell, :wind

    def initialize(day, data)
      @day = day
      @value = data.value
      @swell = Swell.new(self, data.swell)
      @wind = Wind.new(self, data.wind)
    end
  end
end
