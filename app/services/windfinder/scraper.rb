require 'mechanize'

module Windfinder
  class Scraper < ApplicationService

    ShortTerm = Struct.new(:d) do
      def days
        d.map { |day| ForecastDay.new(day) }
      end
    end

    LongTerm = Struct.new(:d) do
      def days
        d.map { |day| ForecastDay.new(day) }
      end
    end

    attr_accessor :url, :type

    def initialize(url, type)
      @url = url
      @type = type
    end

    def scraper
      scraper = Mechanize.new
      scraper.get(url)
      forecast_days = scraper.page.css('.forecast-day')
      forecast = type == 'short_term' ? ShortTerm.new(forecast_days) : LongTerm.new(forecast_days)
    end
  end
end

# s = Windfinder::Scraper.new()

# scraper('https://www.windfinder.com/forecast/rest_bay', 'long_term')
# scraper('https://www.windfinder.com/weatherforecast/rest_bay', 'short_term')
