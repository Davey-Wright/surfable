module Surfable
  class Windows
    attr_reader :times, :tides, :wind, :swell, :daylight

    def initialize(session_conditions, forecast)
      @session_conditions = session_conditions
      @forecast = forecast
      @times = []
    end

    def daylight

    end

    def tides
      TideMatcher.new(spot_session, forecast)
    end

    def wind

    end

    def swell

    end

  end
end

# times = [{from: nil, to: nil}]
