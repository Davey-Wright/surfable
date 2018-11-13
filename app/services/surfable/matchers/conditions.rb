module Surfable
  module Matchers
    class Conditions < ApplicationService
      def initialize(window_hour, forecast_hour, spot_conditions)
        @window_hour = window_hour
        @forecast_hour = forecast_hour
        @spot_conditions = spot_conditions
      end

      def call
        r = Struct.new :time, :swell, :wind, :surfable
        report = r.new
        report.time = @window_hour
        report.swell = swell_matcher(@spot_conditions.swell, @forecast_hour.swell)
        report.wind = wind_matcher(@spot_conditions.wind, @forecast_hour.wind)
        report.surfable = r.swell.surfable && r.wind.surfable
        report
      end

      private

        def wind_matcher(conditions, forecast)
          r = Struct.new :speed, :direction, :surfable
          report = r.new
          report.surfable = (report.speed = forecast.average_speed - conditions.speed) <= 0
          # direction should include onshore and offshore cases
          report
        end

        def swell_matcher(conditions, forecast)
          r = Struct.new :min_height, :max_height, :period, :direction, :surfable
          report = r.new
          s1 = (conditions.max_height != nil) ? (report.max_height = forecast.height - conditions.max_height) <= 0 : true
          s2 = (report.min_height = forecast.height - conditions.min_height) >= 0
          s3 = (report.period = forecast.period - conditions.min_period) >= 0
          s4 = (report.direction = conditions.direction.include? cnv_direction(forecast.direction))
          report.surfable = s1 && s2 && s3 && s4
          report
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
