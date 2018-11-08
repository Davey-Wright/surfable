module Surfable
  class Reports
    attr_reader :swell, :wind

    def initialize(spot_session, forecast_day, window_times)
      @spot_session = spot_session
      @forecast_day = forecast_day
      @window_times = window_times
      @swell
      @wind
    end

    private

      def report_wind
        report = report_struct.new
      end

      def report_swell
        report = report_struct.new
      end

      def report_struct
        Struct.new :user, :forecast, :report
      end
  end
end
