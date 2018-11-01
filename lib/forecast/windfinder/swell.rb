module Windfinder
  class Swell
    attr_accessor :hour, :direction, :height, :period

    def initialize(hour, shaka)
      @hour = hour
      @direction = shaka.css('.units-wad-deg').text.to_i
      @height = shaka.css('.data-waveheight .units-wh').text.to_f
      @period = shaka.css('.data-wavefreq').text.to_i
    end
  end
end
