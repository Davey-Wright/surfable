module Forecast
  module Admiralty
    class ForecastResponse
      attr_reader :http_response, :days

      def initialize(http_response, days)
        @http_response = http_response
        @days = days
      end

      def success?
        http_response.code == 200
      end

      def error
        { code: http_response.code, message: http_response.message }
      end

      def set_tides
        @days.each do |day|
          date = day.date
          t = admiralty_api.select { |tide| Time.parse(tide['DateTime']).day == date }
          t.map do |tide|
            time = Time.parse(tide['DateTime']).strftime('%k:%M')
            {
              'type'    => tide['EventType'],
              'height'  => tide['Height'],
              'time'    => time
            }
          end
        end
      end

      private

      # def get_tides_for(date)
      #   t = admiralty_api.select { |tide| Time.parse(tide['DateTime']).day == date }
      #   t.map do |tide|
      #     time = Time.parse(tide['DateTime']).strftime('%k:%M')
      #     {
      #       'type'    => tide['EventType'],
      #       'height'  => tide['Height'],
      #       'time'    => time
      #     }
      #   end
      # end

      #   @tides = Tide.new(data['tides'])

    end
  end
end
