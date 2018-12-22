module Surfable
  module Matchers
    class Tides < ApplicationService
      attr_reader :times

      def initialize(spot, forecast_day)
        @user_tide = spot.tide
        @forecast_date = forecast_day.date
        @forecast_tides = forecast_day.tides.data
        @times = []
      end

      def call
        return self if !match_size
        return self if full_range?
        offset_times
        self
      end

      private

        def match_size
          high_tides = @forecast_tides.select { |t| t.type == 'high' }
          forecast_tide_size = (high_tides.first.height + high_tides.last.height) / 2
          @user_tide.size.include? forecast_tide_size.to_i
        end

        def full_range?
          if full_range_rising? && full_range_dropping?
            @times.push [day_start, day_end]
            return true
          end
        end

        def full_range_rising?
          @user_tide.rising.count == 6
        end

        def full_range_dropping?
          @user_tide.dropping.count == 6
        end

        def offset_times
          return if @user_tide.rising.blank? && @user_tide.dropping.blank?
          set_rising_times
          set_dropping_times
        end

        def set_times(tide_type, offsets)
          @forecast_tides.each_with_index do |tide, i|
            if tide.type == tide_type
              offsets.each do |o|
                start = same_day_start? tide.time + (o.min - 1).hours
                finish =
                  if o.max == 6 && @forecast_tides[i + 1] != nil
                    @forecast_tides[i + 1].time
                  else
                    same_day_finish? tide.time + o.max.hours
                  end
                # time = trim_with_daylight_hours(start finish)
                @times.push [start, finish] if start && finish
              end
            end
          end
        end

        def same_day_start?(time)
          time = day_start if time < day_start
          time = nil if time > day_end
          time
        end

        def same_day_finish?(time)
          time = nil if time < day_start
          time = day_end if time > day_end
          time
        end

        def first_tide(offset)
          tide = @forecast_tides.first.time
          time = tide - 6.hours
          start = same_day_start? time + (offset.min - 1).hours
          finish =
            if offset.max == 6
              tide
            else
              same_day_finish? time + offset.max.hours
            end
          @times.push [start, finish]
        end

        def set_rising_times
          tide = 'low'
          offsets = slice_consec @user_tide.rising
          offsets.each { |o| first_tide(o) } if tide != @forecast_tides.first.type
          set_times(tide, offsets)
        end

        def set_dropping_times
          tide = 'high'
          offsets = slice_consec @user_tide.dropping
          offsets.each { |o| first_tide(o) } if tide != @forecast_tides.first.type
          set_times(tide, offsets)
        end

        def day_start
          @forecast_date.beginning_of_day
        end

        def day_end
          @forecast_date.change({ hour: 23, min: 59 })
        end

        def slice_consec(tide)
          tide.slice_when { |prev, curr| curr != prev.next }.to_a
        end
    end
  end
end
