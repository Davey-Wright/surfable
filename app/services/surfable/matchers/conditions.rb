module Surfable
  module Matchers
    class Conditions < ApplicationService
      def initialize(window_hour, forecast_hour, spot_conditions)
        @window_hour = window_hour
        @forecast_hour = forecast_hour
        @spot_conditions = spot_conditions
      end

      def call
        report = Struct.new :time, :swell, :wind, :surfable
        r = report.new
        r.time = @window_hour
        r.swell = swell_matcher(@spot_conditions.swell, @forecast_hour.swell)
        r.wind = wind_matcher(@spot_conditions.wind, @forecast_hour.wind)
        r.surfable = r.swell.surfable && r.wind.surfable
        r
      end

      private

        def wind_matcher(session, forecast)
          report = Struct.new :speed, :direction, :surfable
          r = report.new
          r.surfable = (r.speed = forecast.average_speed - session.speed) <= 0
          # direction should include onshore and offshore cases
          r
        end

        def swell_matcher(session, forecast)
          report = Struct.new :min_height, :max_height, :period, :direction, :surfable
          r = report.new
          s1 = (session.max_height != nil) ? (r.max_height = forecast.height - session.max_height) <= 0 : true
          s2 = (r.min_height = forecast.height - session.min_height) >= 0
          s3 = (r.period = forecast.period - session.min_period) >= 0
          s4 = (r.direction = session.direction.include? cnv_direction(forecast.direction))
          r.surfable = s1 && s2 && s3 && s4
          r
        end

        def cnv_direction(d)
          direction = case d
            when (0..22) || (337..360)
              'n'
            when 23..68
              'ne'
            when 69..112
              'e'
            when 113..157
              'se'
            when 158..202
              's'
            when 203..247
              'sw'
            when 248..292
              'w'
            when 293..337
              'nw'
          end
          direction
        end
    end
  end
end
