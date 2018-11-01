module Forecast
  class Day
    attr_accessor :date, :hours, :tides, :sunrise, :sunset, :first_light, :last_light

    def initialize
      @date
      @hours = []
      @tides
      @sunrise
      @sunset
      @first_light
      @last_light
    end

  end
end


#   @tides = Tide.new(data['tides'])
