module Forecast
  module SunriseSunset
    class ForecastResponse
      attr_reader :http_response

      def initialize(http_response)
        @http_response = http_response
      end

      def success?
        http_response.code == 200
      end

      def error
        { code: http_response.code, message: http_response.message }
      end

    end
  end
end
