module Forecast
  class Swell
    attr_reader :hour, :height, :period, :direction

    def initialize(hour, data)
      data = data['swell']['components']['primary']
      @hour = hour
      @height = data['height']
      @period = data['period']
      @direction = data['direction']
    end
  end
end
