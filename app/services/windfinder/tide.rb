module Windfinder
  class Tide
    attr_accessor :hour, :type, :time, :height

    def initialize(hour)
      @hour = hour
      @type = hour.css('.data-tidedirection__symbol')[0]['class'].split(' ').last.split('-').last
      @time = hour.css('.data-tidefreq .value').text.presence
      @height = hour.css('.data-tideheight .units-wh').text.to_f
    end
  end
end
