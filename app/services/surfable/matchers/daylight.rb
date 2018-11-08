module Surfable
  module Matchers
    class Daylight < ApplicationService
      attr_reader :times

      def initialize(tide, forecast)
        @tide_times = tide.times
        @first_light = forecast.first_light
        @last_light = forecast.last_light
        @times = []
      end

      def call
        match_times
        self
      end

      private

        def match_times
          @tide_times.each do |t|
            trim_times(t) if daylight?(t)
          end
        end

        def daylight?(t)
          return false if t[:from] < @first_light && t[:to] < @first_light
          return false if t[:from] > @last_light && t[:to] > @last_light
          true
        end

        def trim_times(t)
          t[:from] = @first_light + 10.minutes if t[:from] < @first_light
          t[:to] = @last_light - 10.minutes if t[:to] > @last_light
          @times.push(t)
        end
    end
  end
end
