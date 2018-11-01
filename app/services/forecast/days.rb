module Forecast
  class Days
    attr_accessor :days, :type

    def initialize(type)
      @days
      @type = type
    end

    def fetch
      if type == 'api'
        @days = MagicSeaweed::ForecastRequest.new(ENV['MSW_KEY'], 'porthcawl').response.forecast
      end
    end

    # def get_forecast_days
    #   date = Time.at(msw_api.first['localTimestamp']).day
    #   forecast_days = []
    #   hours = []
    #   msw_api.each do |response|
    #     if get_date_from(response) == date
    #       hours.push response
    #     else
    #       data = {
    #         'date'  => Time.at(response['localTimestamp']).strftime('%F'),
    #         'tides' => get_tides_for(date),
    #         'sunrise_sunset' => sunrise_sunset_api[forecast_days.count],
    #         'hours' => hours
    #       }
    #       forecast_days.push Day.new(self, data)
    #       date = get_date_from(response)
    #       hours = [response]
    #     end
    #   end
    #   forecast_days
    # end
    #
    # def get_tides_for(date)
    #   t = admiralty_api.select { |tide| Time.parse(tide['DateTime']).day == date }
    #   t.map do |tide|
    #     time = Time.parse(tide['DateTime']).strftime('%k:%M')
    #     {
    #       'type'    => tide['EventType'],
    #       'height'  => tide['Height'],
    #       'time'    => time
    #     }
    #   end
    # end
    #
    # def get_date_from(data)
    #   Time.at(data['localTimestamp']).day
    # end

  end
end
