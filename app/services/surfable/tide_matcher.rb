module Surfable
  class TideMatcher < ApplicationService
    attr_reader :times, :size

    def initialize(user_tides, forecast_tides)
      @user_tides = user_tides
      @forecast_tides = forecast_tides
      @times = []
      @size
    end

    def call
      get_low
      get_high
      self
    end

    private

      def get_low
        before_offset = @user_tides.position_high_low.last
        after_offset = @user_tides.position_low_high.first
        return if before_offset == 0 && after_offset == 0
        match('low', before_offset, after_offset)
      end

      def get_high
        before_offset = @user_tides.position_high_low.first
        after_offset = @user_tides.position_low_high.last
        return if before_offset == 0 && after_offset == 0
        match('high')
      end

      def match(type, before_offset, after_offset)
        @forecast_tides.data.each do |tide|
          if tide.type == type
            time = tide.time
            @times.push({
              from: (time + before_offset.hours),
              to: (time + after_offset.hours)
            })
          end
        end
      end

  end
end
