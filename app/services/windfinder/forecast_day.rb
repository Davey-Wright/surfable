module Windfinder
  class ForecastDay < ApplicationService
    attr_reader :day, :date, :hours, :high_tide, :low_tide

    def initialize(day)
      @day = day.css('.weathertable__body .weathertable__row')
      @date = day.css('.weathertable__headline, .weathertable__header h4').text.strip
      @hours = @day.map { |hour| ForecastHour.new(hour) }
      @high_tide = []
      @low_tide = []
      @first_light = nil
      @last_light = nil
    end

    def set_high_tide
      @hours.each do |hour|
        if hour.tide.type == 'high'
          @high_tide.push ({
            time: hour.tide.time,
            height: hour.tide.height
          })
        end
      end
    end

    def set_low_tide
      @hours.each do |hour|
        tide = {
          time: nil,
          height: nil
        }
        if hour.tide.type == 'low'
          @low_tide.push {
            tide.time = hour.tide.time,
            time.hight =  hour.tide.height
          }
        end
      end
    end

  end
end
