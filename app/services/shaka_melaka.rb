# add edge case for middle forecast time failing
# run window_times against daylight_hours
  module Surfable
    class ShakaMelaka < ApplicationService
      attr_reader :times, :window_times

      def initialize(session_window)
        @session_window = session_window
        @forecast_day = session_window.forecast_day
        @session_conditions = session_window.session_conditions
        @window_times = session_window.times
        @times = []
      end

      def call
        @window_times.each do |time|
          forecast_hours_for(time)
        end
      end

      def forecast_hours_for(time)
        from = time[:from]
        to = time[:to]

        @forecast_day.hours.each do |hour|
          if hour.value >= from.to_i && hour.value <= to.to_i
            return unless compare_conditions_for(hour)
            from += 3 if (from += 3) <= to
          end
        end
        @times.push({ from: from, to: to })
      end

      def compare_conditions_for(hour)
        return false unless tide
        return false unless swell(hour)
        return false unless wind(hour)
        end
      end

      def swell(hour)
        session = @session_conditions.swell
        forecast = hour.swell
        return false if session.min_height >= forecast.height
        return false if session.max_height <= forecast.height
        return false if session.min_period >= forecast.period
        return false if direction(session.direction, forecast.direction)
        return true
      end

      def tide
        session = @session_conditions.tide
        forecast_tide = tide_size
        return false unless user.size.include? forecast_tide
        return true
      end

      def wind(hour)
        session = @session_conditions.wind
        forecast = hour.wind
        forecast_avg = (forecast.gusts - forecast.speed) / 10 + forecast.speed
        return false if session.speed <= forecast_avg
        return false if direction(session.direction, forecast.direction)
        return true
      end

      def daylight_hours(hour)
        sunrise = self.hour.day.sunrise.to_i
        sunset = self.hour.day.sunset.to_i
        return false if sunrise > hour || sunset < hour
      end

      def direction(session_direction, direction)
        forecast_direction = case direction
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
        session_direction.exclude? forecast_direction ? true : false
      end

    end
  end
