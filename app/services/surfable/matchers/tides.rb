module Surfable
  module Matchers
    class Tides < ApplicationService
      attr_reader :times, :size, :match_sizes

      def initialize(user_tides, forecast_tides)
        @user_tides = user_tides
        @forecast_tides = forecast_tides
        @offsets = set_offsets
        @times = []
        @sizes = { user: @user_tides.size, forecast: @forecast_tides.size }
      end

      def call
        return self if full_range?
        match('low')
        match('high')
        self
      end

      def match_size
        @sizes[:user].include?(@sizes[:forecast]) || @sizes[:user].include?('all')
      end

      private

        def set_offsets
          {
            'high' => {
              before: @user_tides.position_high_low.first,
              after: @user_tides.position_low_high.last
            },
            'low' => {
              before: @user_tides.position_high_low.last,
              after: @user_tides.position_low_high.first
            }
          }
        end

        def match(type)
          match_offsets(type)
          @forecast_tides.data.each do |tide|
            if tide.type == type
              time = tide.time
              t = [time + @offsets[type][:before].hours, time + @offsets[type][:after].hours]
              @times.push({ from: t.min, to: t.max })
            end
          end
        end

        def match_offsets(type)
          return if @offsets[type][:before] == 0 && @offsets[type][:after] == 0
        end

        def full_range?
          high = match_high_low
          low = match_low_high
          if high && low
            time = times.first[:from]
            @times = [{
              from: time.change(hour: 0, min: 0, sec: 0),
              to: time.change(hour: 23, min: 59, sec: 59)
            }]
            return true
          end
          return true if high || low
        end

        def match_high_low
          a = @user_tides.position_high_low.first
          b = @user_tides.position_high_low.last
          if a + b.abs == 6
            @forecast_tides.data.each_with_index do |tide, i|
              if tide.type == 'high'
                @times.push({ from: tide.time, to: shaka(i, tide.time) })
              end
            end
            true
          end
        end

        def match_low_high
          a = @user_tides.position_low_high.first
          b = @user_tides.position_low_high.last
          if a + b.abs == 6
            @forecast_tides.data.each_with_index do |tide, i|
              if tide.type == 'low'
                @times.push({ from: tide.time, to: shaka(i, tide.time) })
              end
            end
            true
          end
        end

        def shaka(i, t)
          if i + 1 < @forecast_tides.data.count
            @forecast_tides.data[i+1].time
          else
            t.change(hour: 23, min: 59, sec: 59)
          end
        end

    end
  end
end
