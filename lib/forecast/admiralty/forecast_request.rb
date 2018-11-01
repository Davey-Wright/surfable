module Forecast
  module Admiralty
    class ForecastRequest
      attr_reader :days

      def initialize(days)
        @days = days
      end

      def response
        url = "https://admiraltyapi.azure-api.net/uktidalapi/api/V1/Stations/0512/TidalEvents?duration=#{days.count}"
        headers = { 'Ocp-Apim-Subscription-Key': ENV['ADMIRALTY_PRIMARY_KEY'] }
        http_response = HTTParty.get(url, headers: headers)
        ForecastResponse.new(http_response, days)
      end

    end
  end
end
