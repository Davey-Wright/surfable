module Windfinder
  class Wind
    attr_accessor :direction, :speed, :gusts

    def initialize(hour)
      @direction = hour.css('.units-wd-deg').text.to_i
      @speed = (hour.css('.speed .units-ws').text.to_i * 0.869).round
      @gusts = (hour.css('.data-gusts .units-ws').text.to_i * 0.869).round
    end
  end
end
