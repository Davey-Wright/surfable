module Forecast
  class Forecast < ApplicationService
    attr_reader :days, :tides

    def initialize
      @days = get_forecast_days
      @tides
    end

    def get_msw_api
      HTTParty.get("http://magicseaweed.com/api/#{ENV['MSW_KEY']}/forecast/?spot_id=1449")
    end

    def get_admiralty_api
      HTTParty.get(
        'https://admiraltyapi.azure-api.net/uktidalapi/api/V1/Stations/0512/TidalEvents?duration=4',
        headers: { 'Ocp-Apim-Subscription-Key' => ENV['ADMIRALTY_PRIMARY_KEY'] }
      )
    end

    def get_forecast_days
      date = Time.at(get_msw_api.first['localTimestamp']).day
      forecast_days = []
      hours = []
      get_msw_api.each do |data|
        if get_date_from(data) == date
          hours.push data
        else
          day = {
            'date'  => Time.at(data['localTimestamp']).strftime('%F'),
            'tides' => tides_for(date),
            'hours' => hours
          }
          forecast_days.push Day.new(self, day)
          date = get_date_from(data)
          hours = [data]
        end
      end
      forecast_days
    end

    def tides_for(date)
      response = get_admiralty_api
      t = response.select { |tide| Time.parse(tide['DateTime']).day == date }
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
