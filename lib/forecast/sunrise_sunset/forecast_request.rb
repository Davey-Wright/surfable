module Forecast
  module SunriseSunset
    class ForecastRequest
      attr_reader :key, :spot, :response

      def initialize(key, spot)
        @key = key
        @spot = spot
      end

      def response
        url = "http://magicseaweed.com/api/#{key}/forecast/?spot_id=#{spot_id}"
        http_response = HTTParty.get(url)
        ForecastResponse.new(http_response)
      end

      private

    end
  end
end
