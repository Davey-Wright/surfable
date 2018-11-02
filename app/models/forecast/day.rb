module Forecast
  class Day < ApplicationRecord::Associations
    has_many :hours
    has_one :tide
    attr_reader :date, :hours, :tides, :sunrise, :sunset, :first_light, :last_light

    def initialize(data)
      @date = data.date
      @hours =
      @tides = Tide.new(data.tides)
      @first_light = data.first_light
      @sunrise = data.sunrise
      @sunset = data.sunset
      @last_light = data.last_light
    end
  end
end


# forecast_data = Forecast::Mappers.call
# forecast = Forecast::Day.new(forecast_data).forecast
