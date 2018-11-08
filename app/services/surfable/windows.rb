module Surfable
  class Windows
    attr_reader :times

    def initialize(spot_session, forecast)
      tide = Matchers::Tides.call(spot_session, forecast)
      @times = Matchers::Daylight.call(tide, forecast).times
    end
  end
end
