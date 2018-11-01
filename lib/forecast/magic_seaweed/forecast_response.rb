module Forecast
  module MagicSeaweed
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

      def set_forecast
        dates = http_response.map { |res| get_date(res) }.uniq
        forecast = []
        dates.each do |date|
          day = Forecast::Day.new
          day.date = date
          http_response.each do |response|
            day.hours.push(response) if date == get_date(response)
          end
          forecast.push(day)
        end

        forecast
      end

      private

      def get_date(data)
        Time.at(data['localTimestamp']).strftime('%F')
      end
    end
  end
end
