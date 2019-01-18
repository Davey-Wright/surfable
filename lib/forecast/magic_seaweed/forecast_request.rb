module Forecast
  module MagicSeaweed
    class ForecastRequest
      attr_reader :key

      def initialize(key)
        @key = key
      end

      def response
        url = "http://magicseaweed.com/api/#{key}/forecast/?spot_id=1449"
        response = Rails.cache.fetch('msw_api_res', expires_in: 3.hours) do
          res = HTTParty.get(url)
          res.to_a if res.success?
        end
        ForecastResponse.new(response)
      end
    end
  end
end
