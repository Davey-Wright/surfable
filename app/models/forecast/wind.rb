module Forecast
  class Wind
    attr_reader :speed, :gusts, :average_speed, :direction

    def initialize(data)
      @speed = data['speed']
      @gusts = data['gusts']
      @average_speed = set_average_speed
      @direction = data['direction']
    end

    private

    def set_average_speed
      (@speed - @gusts) / 10 + @speed
    end
  end
end
