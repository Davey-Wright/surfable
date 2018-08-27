class Forecasts::WindfinderController < ApplicationController
  def short_term
    @forecast = Windfinder::Scraper.new('https://www.windfinder.com/weatherforecast/rest_bay', 'short_term').scraper
  end

  def long_term
    @forecast = Windfinder::Scraper.new('https://www.windfinder.com/forecast/rest_bay', 'long_term').scraper
  end
end
