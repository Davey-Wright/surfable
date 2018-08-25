module WindfinderForecasts
  class Wave
    attr_accessor :direction_deg, :direction_dir, :height, :period

    def initialize(hour)
      @direction_deg = hour.css('.units-wad-deg').text.to_i
      @direction_dir = hour.css('.units-wad-dir').text.strip
      @height = hour.css('.data-waveheight .units-wh').text.to_f
      @period = hour.css('.data-wavefreq').text.to_i
    end
  end
end
