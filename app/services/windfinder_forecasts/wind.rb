module WindfinderForecasts
  class Wind
    attr_accessor :direction_deg, :direction_dir, :speed, :gusts

    def initialize(hour)
      @direction_deg = hour.css('.units-wd-deg').text.to_i
      @direction_dir = hour.css('.units-wd-dir').text.strip
      @speed = (hour.css('.speed .units-ws').text.to_i * 0.869).round
      @gusts = (hour.css('.data-gusts .units-ws').text.to_i * 0.869).round
    end
  end
end
