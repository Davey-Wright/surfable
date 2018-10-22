require 'mechanize'

module Windfinder
  class Forecast
    attr_reader :url, :type, :scraper, :days

    def initialize(url, type)
      @url = url
      @type = type
      @scraper = scrape
      @days = get_days
    end

  private

    def get_days
      forecast_days = scraper.page.css('.forecast-day')
      forecast_days.map { |day| ForecastDay.new(self, day) }
    end

    def scrape
      scraper = Mechanize.new
      scraper.get(url)
      scraper
    end
  end
end

# scraper('https://www.windfinder.com/forecast/rest_bay', 'long_term')
# scraper('https://www.windfinder.com/weatherforecast/rest_bay', 'short_term')

# s = Windfinder::Scraper.new('https://www.windfinder.com/forecast/rest_bay', 'long_term')
