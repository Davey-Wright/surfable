module Api
  class ForecastsController < ApplicationController
    def long_term
      scraper('https://www.windfinder.com/forecast/rest_bay', 'long_term')
    end

    def short_term
      scraper('https://www.windfinder.com/weatherforecast/rest_bay', 'short_term')
    end

    def scraper(url, type)
      scraper = Mechanize.new
      scraper.get(url)
      forecast_days = scraper.page.css('.forecast-day')
      forecasts = scrape_forecast(forecast_days, type)
      render json: JSON.pretty_generate(forecasts)
    end

    def scrape_forecast(forecast_days, type)
      forecasts = []
      forecast_days.each_with_index do |day, index|
        forecast_hours = day.css('.weathertable__body .weathertable__row')
        date = {
          type:       type,
          hours:      forecast_hours.count,
          date:       day.css('.weathertable__headline, .weathertable__header h4').text.strip,
          forecast:   []
        }
        forecasts.push(date)
        forecast_hours.each do |hour|
          forecast = {
            wave: {
              direction: {
                units_deg:    hour.css('.units-wad-deg').text.to_i,
                units_dir:    hour.css('.units-wad-dir').text.strip
              },
              height:         hour.css('.data-waveheight .units-wh').text.to_f,
              period:         hour.css('.data-wavefreq').text.to_i
            },
            wind: {
              direction: {
                units_deg:    hour.css('.units-wd-deg').text.to_i,
                units_dir:    hour.css('.units-wd-dir').text.strip
              },
              speed:          (hour.css('.speed .units-ws').text.to_i * 0.869).round,
              gusts:          (hour.css('.data-gusts .units-ws').text.to_i * 0.869).round
            },
            tide: {
              type:           nil,
              time:           hour.css('.data-tidefreq .value').text,
              height:         hour.css('.data-tideheight .units-wh').text.to_f
            }
          }
          forecasts[index][:forecast].push(forecast)
        end
      end

      forecasts
    end
  end
end
