module Forecast
  module SunriseSunset
    class ForecastResponse
      attr_reader :http_response, :day

      def initialize(http_response, day)
        @http_response = http_response
        @day = day
      end

      def success?
        http_response.code == 200
      end

      def error
        { code: http_response.code, message: http_response.message }
      end

      def set_daylight_hours
        day.sunrise = set_time_for('sunrise', http_response)
        day.sunset = set_time_for('sunset', http_response)
        day.first_light = set_time_for('civil_twilight_begin', http_response)
        day.last_light = set_time_for('civil_twilight_end', http_response)
      end

      private

      def set_time_for(key, data)
        time = data['results'][key]
        Time.use_zone('London') { Time.zone.parse(time).strftime('%H:%M') }
      end

    end
  end
end
