module Windfinder
  class Swell
    attr_accessor :direction, :height, :period

    def initialize(hour)
      @direction = hour.css('.units-wad-deg').text.to_i
      @height = hour.css('.data-waveheight .units-wh').text.to_f
      @period = hour.css('.data-wavefreq').text.to_i
    end
  end
end
