module WindfinderForecasts
  class ForecastDay < ApplicationService
    attr_accessor :day, :date, :hours

    def initialize(day)
      @day = day.css('.weathertable__body .weathertable__row')
      @date = day.css('.weathertable__headline, .weathertable__header h4').text.strip
      @hours = get_hours
    end

    def get_hours
      day.map { |hour| ForecastHour.new(hour) }
    end
  end
end
