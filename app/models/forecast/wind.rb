module Forecast
  class Wind
    attr_reader :hour, :speed, :gusts, :average_speed, :direction

    def initialize(hour, data)
      @hour = hour
      @speed = data.speed
      @gusts = data.gusts
      @average_speed = @speed + ((@gusts - @speed) * 0.2).to_i
      @direction = data.direction
    end
  end
end
