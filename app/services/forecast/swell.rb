module Forecast
  class Swell
    attr_reader :hour, :height, :period, :direction

    def initialize(hour, data)
      @hour = hour
      @data = data['swell']['components']['primary']
      @height = @data['height']
      @period = @data['period']
      @direction = @data['direction']
    end
  end
end
