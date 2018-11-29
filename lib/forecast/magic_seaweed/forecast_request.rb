module Forecast
  module MagicSeaweed
    class ForecastRequest
      attr_reader :key

      def initialize(key)
        @key = key
      end

      def response
        url = "http://magicseaweed.com/api/#{key}/forecast/?spot_id=1449"
        http_response = HTTParty.get(url)
        ForecastResponse.new(http_response)
      end
    end
  end
end
