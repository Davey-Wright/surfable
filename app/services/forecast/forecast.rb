require 'magic_seaweed_api'
require 'admiralty_api'
require 'sunrise_sunset_api'

module Forecast
  class Forecast < ApplicationService
    attr_reader :days

    def initialize
      @days = get_forecast_days
    end

    def msw_api
      MagicSeaweedAPI.new.response
    end

    def admiralty_api
      AdmiraltyAPI.new.response
    end

    def sunrise_sunset_api
      SunriseSunsetAPI.new.response
    end

    def get_forecast_days
      date = Time.at(msw_api.first['localTimestamp']).day
      forecast_days = []
      hours = []
      msw_api.each do |response|
        if get_date_from(response) == date
          hours.push response
        else
          data = {
            'date'  => Time.at(response['localTimestamp']).strftime('%F'),
            'tides' => get_tides_for(date),
            'sunrise_sunset' => sunrise_sunset_api[forecast_days.count],
            'hours' => hours
          }
          forecast_days.push Day.new(self, data)
          date = get_date_from(response)
          hours = [response]
        end
      end
      forecast_days
    end

    def get_tides_for(date)
      t = admiralty_api.select { |tide| Time.parse(tide['DateTime']).day == date }
      t.map do |tide|
        time = Time.parse(tide['DateTime']).strftime('%k:%M')
        {
          'type'    => tide['EventType'],
          'height'  => tide['Height'],
          'time'    => time
        }
      end
    end

    def get_date_from(data)
      Time.at(data['localTimestamp']).day
    end

  end
end
