module Forecast
  module SunriseSunset
    class ForecastRequest
      attr_reader :day

      def initialize(day)
        @day = day
      end

      def response
        url = "https://api.sunrise-sunset.org/json?lat=51.48&lng=-3.69&formatted=0&date=#{day.date}"
        http_response = HTTParty.get(url)
        ForecastResponse.new(day, http_response)
      end

    end
  end
end
