module Surfable
  module Matchers
    class Tides < ApplicationService
      attr_reader :forecast

      def initialize(spot, forecast_day)
        @user_tide = spot.tide
        @forecast_date = forecast_day.date
        @forecast_tides = forecast_day.tides.data
        @first_light = forecast_day.first_light
        @last_light = forecast_day.last_light
        @forecast = []
      end

      def call
        return self unless match_size
        return self if full_range_tides?
        set_times
        self
      end

      private

      def match_size
        high_tides = @forecast_tides.select { |t| t.type == 'high' }
        forecast_tide_size = (high_tides.first.height + high_tides.last.height) / 2
        @user_tide.size.include? forecast_tide_size.to_i
      end

      def full_range_tides?
        if full_range?
          @forecast.push Surfable::Forecast.new(nil, 'all', [@first_light, @last_light])
          true
        else
          false
        end
      end

      def full_range?
        @user_tide.rising.count == 6 && @user_tide.dropping.count == 6
      end

      def set_times
        return if @user_tide.rising.blank? && @user_tide.dropping.blank?
        set_rising_times
        set_dropping_times
      end

      def set_rising_times
        offsets = slice_consec @user_tide.rising
        set_first_time('low', offsets) if @forecast_tides.first.type != 'low'
        set_offset_times('low', offsets)
      end

      def set_dropping_times
        offsets = slice_consec @user_tide.dropping
        set_first_time('high', offsets) if @forecast_tides.first.type != 'high'
        set_offset_times('high', offsets)
      end

      def tide_type(tide)
        tide == 'low' ? 'rising' : 'dropping'
      end

      def set_first_time(tide, offsets)
        offsets.each do |offset|
          tide_time = @forecast_tides.first.time
          prev_tide = tide_time - 6.hours
          start = same_day_start? prev_tide + offset.min.hours
          finish =
            if offset.max == 6
              tide_time
            else
              same_day_finish? prev_tide + offset.max.hours
            end
          if start && finish
            start = filter_daylight_start(start)
            finish = filter_daylight_end(finish)
          end
          if start && finish
            @forecast.push Surfable::Forecast.new(nil, tide_type(tide), [start, finish])
          end
        end
      end

      def set_offset_times(tide, offsets)
        times = []
        @forecast_tides.each_with_index do |f, i|
          if f.type == tide
            offsets.each do |o|
              start =
                if o.min == 1
                  f.time
                else
                  same_day_start? f.time + (o.min.hours - 1.hour)
                end
              finish =
                if o.max == 6 && !@forecast_tides[i + 1].nil?
                  @forecast_tides[i + 1].time
                else
                  same_day_finish? f.time + o.max.hours
                end
              if start && finish
                start = filter_daylight_start(start)
                finish = filter_daylight_end(finish)
              end
              if start && finish
                @forecast.push Surfable::Forecast.new(nil, tide_type(tide), [start, finish])
              end
            end
          end
        end
        times
      end

      def filter_daylight_start(time)
        return time if time > @first_light && time < @last_light
        return @first_light if time < @first_light
      end

      def filter_daylight_end(time)
        return time if time > @first_light && time < @last_light
        return @last_light if time > @last_light
      end

      def same_day_start?(time)
        return if time > day_end
        time = day_start if time < day_start
        time
      end

      def same_day_finish?(time)
        return if time < day_start
        time = day_end if time > day_end
        time
      end

      def day_start
        @forecast_date.beginning_of_day
      end

      def day_end
        @forecast_date.change(hour: 23, min: 59)
      end

      def slice_consec(tide)
        tide.slice_when { |prev, curr| curr != prev.next }.to_a
      end
    end
  end
end
