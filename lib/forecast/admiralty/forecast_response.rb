module Forecast
  module Admiralty
    class ForecastResponse
      attr_reader :http_res

      def initialize(http_res, days)
        @http_res = http_res
        @days = days
      end

      def success?
        http_res.code == 200
      end

      def error
        { code: http_res.code, message: http_res.message }
      end

      def mapper
        @days.each do |day|
          tides = http_res.select do |res|
            Time.parse(res['DateTime']).strftime('%F') == day.date
          end
          day.tides = tides.map { |res| tide_mapper(res) }
        end
      end

      private

      def tide_mapper(res)
        tide = Forecast::Mappers.tide_struct.new
        tide.type = res['EventType'] == 'HighWater' ? 'high' : 'low'
        tide.height = res['Height'].round(2)
        tide.time = Time.parse(res['DateTime'])
        tide
      end
    end
  end
end
