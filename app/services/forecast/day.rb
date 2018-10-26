module Forecast
  class Day
    attr_accessor :forecast, :date, :hours, :tides,
      :sunrise, :sunset, :first_light, :last_light

    def initialize(forecast, data)
      @forecast = forecast
      @date = data['date']
      @hours = data['hours'].map { |hour| Hour.new(self, hour) }
      @tides = Tide.new(data['tides'])
      @sunrise
      @sunset
      @first_light
      @last_light
    end

    def set_tide(type)
      tide = []
      @hours.each do |hour|
        if hour.tide.type == type
          tide.push ({
            time: hour.tide.time,
            height: hour.tide.height
          })
        end
      end
      tide
    end
  end


end
