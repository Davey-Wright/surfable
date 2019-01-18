module Forecast
  module Admiralty
    class ForecastRequest
      def initialize(days)
        @days = days
      end

      def response
        url = "https://admiraltyapi.azure-api.net/uktidalapi/api/V1/Stations/0512/TidalEvents?duration=#{@days.count}"
        headers = { 'Ocp-Apim-Subscription-Key': ENV['ADMIRALTY_PRIMARY_KEY'] }

        end_of_day = Time.current.end_of_day - Time.current
        response = Rails.cache.fetch('admiralty_api_res', expires_in: end_of_day) do
          res = HTTParty.get(url, headers: headers)
          res.to_a if res.success?
        end
        ForecastResponse.new(response, @days)
      end
    end
  end
end
