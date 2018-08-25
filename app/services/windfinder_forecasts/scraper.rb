require 'mechanize'

module WindfinderForecasts
  class Scraper < ApplicationService
    attr_accessor :url

    def initialize
      @url = 'https://www.windfinder.com/weatherforecast/rest_bay'
    end

    def scraper
      scraper = Mechanize.new
      scraper.get(url)
      forecast_days = scraper.page.css('.forecast-day')
      forecast = ShortTermForecast.new(forecast_days)
    end
  end
end

# WindfinderForecasts::ForecastScraper

# scraper('https://www.windfinder.com/forecast/rest_bay', 'long_term')
# scraper('https://www.windfinder.com/weatherforecast/rest_bay', 'short_term')
