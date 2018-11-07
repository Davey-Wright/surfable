module Surfable
  class Ting < ApplicationService
    attr_reader :times

    def initialize(session_conditions, forecast_day)
      @session_conditions = session_conditions
      @forecast_day = forecast_day
      @times = []
      @wind_speed = session_conditions.wind.speed
      @swell_height = {
        min: session_conditions.swell.min_height,
        max: session_conditions.swell.max_height
        }
    end

    def call
      get_low
      get_high
      self
    end

    def get_low
      before_low_offset = @session_conditions.tide.position_high_low.last
      after_low_offset = @session_conditions.tide.position_low_high.first
      return if before_low_offset == 0 && after_low_offset == 0

      @forecast_day.tides.low.each do |tide|
        before_low_time = (time + before_low_offset.hours).strftime("%k:%M").strip
        after_low_time = (time + after_low_offset.hours).strftime("%k:%M").strip
        @times.push({ from: before_low_time, to: after_low_time })
      end
    end

    def get_high
      before_high_offset = @session_conditions.tide.position_high_low.first
      after_high_offset = @session_conditions.tide.position_low_high.last
      return if before_high_offset == 0 && after_high_offset == 0

      @forecast_day.high_tide.each do |tide|
        time = Time.parse(tide[:time])
        before_high_time = (time + before_high_offset.hours).strftime("%k:%M").strip
        after_high_time = (time + after_high_offset.hours).strftime("%k:%M").strip
        @times.push({ from: before_high_time, to: after_high_time })
      end
    end

  end
end
