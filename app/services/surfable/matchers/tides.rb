module Surfable
  module Matchers
    class Tides < ApplicationService
      attr_reader :times

      def initialize(spot, forecast)
        @user_tides = spot.tide
        @forecast_tides = forecast.tides
        @times = []
      end

      def call
        match_sizes
      end

      def match_sizes
        high_tides = @forecast_tides.data.select { |t| t.type == 'high' }
        forecast_tide_size = (high_tides.first.height + high_tides.last.height) / 2
        @user_tides.size.include? forecast_tide_size.to_i
      end

    end
  end
end
