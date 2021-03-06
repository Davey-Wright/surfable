module Forecast
  class Swell
    attr_reader :hour, :height, :period, :direction

    def initialize(hour, data)
      @hour = hour
      @height = data.height
      @period = data.period
      @direction = data.direction.to_i
    end
  end
end
