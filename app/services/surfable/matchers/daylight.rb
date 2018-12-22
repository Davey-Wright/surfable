module Surfable
  module Matchers
    class Daylight < ApplicationService
      attr_reader :times

      def initialize(tide_times, forecast)
        @tide_times = tide_times
        @forecast = forecast
        @times = []
      end

      def call
        
        self
      end

      private

        def first_light
          forecast.first_light + 10.minutes
        end

        def last_light
          forecast.last_light - 10.minutes
        end
    end
  end
end
