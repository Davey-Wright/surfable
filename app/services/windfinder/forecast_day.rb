module Windfinder
  class ForecastDay < ApplicationService
    attr_reader :forecast, :day, :date, :hours, :high_tide,
      :low_tide, :sunrise, :sunset, :first_light, :last_light

    def initialize(forecast, day)
      @forecast = forecast
      @day = day.css('.weathertable__body .weathertable__row')
      @date = day.css('.weathertable__headline, .weathertable__header h4').text.strip
      @hours = @day.map { |hour| ForecastHour.new(day, hour) }
      @high_tide = set_tide('high')
      @low_tide = set_tide('low')
      @sunrise = forecast.scraper.page.css('[data-spotmeta-sunrise]').first.text.strip
      @sunset = forecast.scraper.page.css('[data-spotmeta-sunset]').first.text.strip
      @first_light = nil
      @last_light = nil
    end

  private

    def set_tide(type)
      tide = []
      @hours.each do |hour|
        if hour.tide.type == type
          tide.push ({
            time: hour.tide.time,
            height: hour.tide.height
          })
        end
      end
      tide
    end

  end
end
