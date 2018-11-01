module Forecast
  module SunriseSunset
    class ForecastRequest
      attr_reader :spot, :day

      def initialize(spot, day)
        @spot = spot
        @day = day
      end

      def response
        url = "https://api.sunrise-sunset.org/json?#{coordinates}&formatted=0&date=#{day.date}"
        http_response = HTTParty.get(url)
        ForecastResponse.new(http_response, day)
      end

      private

      def coordinates
        return 'lat=51.48&lng=-3.69' if spot == 'porthcawl'
        return 'lat=48.42&lng=-124.04' if spot == 'jordan river'
      end

    end
  end
end
