module Forecast
  module MagicSeaweed
    class ForecastResponse
      attr_reader :http_res

      def initialize(http_res)
        @http_res = http_res
      end

      def success?
        http_res.code == 200
      end

      def error
        { code: http_res.code, message: http_res.message }
      end

      def mapper
        dates = http_res.map { |res| get_date(res) }.uniq
        dates.map { |date| day_mapper(date) }
      end

      private

      def day_mapper(date)
        day = Forecast::Mappers.day_struct.new
        day.date = date
        hours = http_res.select { |res| date == get_date(res) }
        day.hours = hours.map { |res| hours_mapper(res) }
        day
      end

      def hours_mapper(res)
        hour = Forecast::Mappers.hour_struct.new
        hour.value = Time.at(res['localTimestamp'])
        hour.swell = swell_mapper(res)
        hour.wind = wind_mapper(res)
        hour
      end

      def swell_mapper(res)
        swell = Forecast::Mappers.swell_struct.new
        key = res['swell']['components']['primary']
        swell.height = key['height']
        swell.period = key['period']
        swell.direction = key['direction']
        swell
      end

      def wind_mapper(res)
        wind = Forecast::Mappers.wind_struct.new
        key = res['wind']
        wind.speed = key['speed']
        wind.gusts = key['gusts']
        wind.direction = key['direction']
        wind
      end

      def get_date(res)
        # Time.at(res['localTimestamp'])
        Time.at(res['localTimestamp']).strftime('%F')
      end
    end
  end
end
