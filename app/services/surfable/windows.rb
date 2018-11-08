module Surfable
  class Windows
    attr_reader :times

    def initialize(spot_session, forecast_day)
      tide = Matchers::Tides.call(spot_session, forecast_day)
      @times = Matchers::Daylight.call(tide, forecast_day).times
    end
  end
end
