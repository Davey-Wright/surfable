module Forecast
  class API < ApplicationService
    attr_reader :days

    def initialize
      @days = get_forecast_days
    end

    def msw_api
      HTTParty.get("http://magicseaweed.com/api/#{ENV['MSW_KEY']}/forecast/?spot_id=1449")
    end

    def admiralty_api
      HTTParty.get(
        'https://admiraltyapi.azure-api.net/uktidalapi/api/V1/Stations/0512/TidalEvents?duration=4',
        headers: { 'Ocp-Apim-Subscription-Key' => ENV['ADMIRALTY_PRIMARY_KEY'] }
      )
    end

    def sunrise_sunset_api
      # provide link attribution https://sunrise-sunset.org
      response = []
      4.times do |n|
        date = (Time.now + n.day).strftime('%F')
        url = "https://api.sunrise-sunset.org/json?lat=51.48&lng=-3.69&formatted=0&date=#{date}"
        response.push HTTParty.get(url)
      end
      response
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
      response = admiralty_api
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
