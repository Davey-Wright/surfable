module Forecast
  class Days
    attr_accessor :spot, :type, :days

    def initialize(spot, type)
      @spot = spot
      @type = type
      @days
    end

    def fetch
      surf_forecast
      tides
      daylight_hours
    end

    private

    def surf_forecast
      if type == 'api'
        @days = MagicSeaweed::ForecastRequest.new(ENV['MSW_KEY'], spot).response.set_forecast
      end
    end

    def tides
      Admiralty::ForecastRequest.new(@days).response.set_tides
    end

    def daylight_hours
      @days.each { |day| SunriseSunset::ForecastRequest.new(spot, day).response.set_daylight_hours }
    end

  end
end
