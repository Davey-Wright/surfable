module Forecast
  module SunriseSunset
    class ForecastResponse
      attr_reader :spot, :day, :http_res

      def initialize(spot, day, http_res)
        @spot = spot
        @day = day
        @http_res = http_res
      end

      def success?
        http_res.code == 200
      end

      def error
        { code: http_res.code, message: http_res.message }
      end

      def mapper
        day.sunrise = set_time_for('sunrise', http_res)
        day.sunset = set_time_for('sunset', http_res)
        day.first_light = set_time_for('civil_twilight_begin', http_res)
        day.last_light = set_time_for('civil_twilight_end', http_res)
      end

      private

      def set_time_for(key, res)
        time = res['results'][key]
        zone = spot == 'porthcawl' ? 'London' : 'Pacific Time (US & Canada)'
        Time.use_zone(zone) { Time.zone.parse(time) }
      end

    end
  end
end
