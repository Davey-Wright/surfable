module Forecast
  class Wind
    attr_accessor :hour, :speed, :gusts, :average_speed, :direction

    def initialize(hour, data)
      @hour = hour
      @data = data['wind']
      @speed = @data['speed']
      @gusts = @data['gusts']
      @average_speed = (@speed - @gusts) / 10 + @speed
      @direction = @data['direction']
    end
  end
end
