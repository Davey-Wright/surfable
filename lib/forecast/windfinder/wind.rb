module Windfinder
  class Wind
    attr_accessor :hour, :direction, :speed, :gusts

    def initialize(hour, shaka)
      @hour = hour
      @direction = shaka.css('.units-wd-deg').text.to_i
      @speed = (shaka.css('.speed .units-ws').text.to_i * 0.869).round
      @gusts = (shaka.css('.data-gusts .units-ws').text.to_i * 0.869).round
    end
  end
end
