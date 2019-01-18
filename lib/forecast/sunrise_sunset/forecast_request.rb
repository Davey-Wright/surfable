module Forecast
  module SunriseSunset
    class ForecastRequest
      attr_reader :day

      def initialize(day)
        @day = day
      end

      def response
        url = "https://api.sunrise-sunset.org/json?lat=51.48&lng=-3.69&formatted=0&date=#{day.date}"
        response = Rails.cache.fetch("sunrise_api_#{day.date}", expires_in: 6.days) do
          res = HTTParty.get(url)
          res.to_h if res.success?
        end
        ForecastResponse.new(day, response)
      end

    end
  end
end
