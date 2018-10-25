module Windfinder
  class Tide
    attr_accessor :hour, :type, :time, :height

    def initialize(hour, shaka)
      @hour = hour
      @type = shaka.css('.data-tidedirection__symbol')[0]['class'].split(' ').last.split('-').last
      @time = shaka.css('.data-tidefreq .value').text.presence
      @height = shaka.css('.data-tideheight .units-wh').text.to_f
    end
  end
end
