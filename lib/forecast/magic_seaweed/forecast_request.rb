module Forecast
  module MagicSeaweed
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

      def spot_id
        return '1449' if spot == 'porthcawl'
        return '323' if spot == 'jordan river'
      end

    end
  end
end
