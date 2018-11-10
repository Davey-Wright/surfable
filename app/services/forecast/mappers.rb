module Forecast
  class Mappers < ApplicationService

    def initialize(spot = 'porthcawl')
      @spot = spot
    end

    def call
      days = magicseaweed
      tides(days)
      sunrise_sunset(days)
      days
    end

    def self.day_struct
      Struct.new :date, :tides, :first_light, :sunrise, :sunset, :last_light, :hours
    end

    def self.hour_struct
      Struct.new :value, :swell, :wind
    end

    def self.swell_struct
      Struct.new :height, :period, :direction
    end

    def self.wind_struct
      Struct.new :speed, :gusts, :direction
    end

    def self.tide_struct
      Struct.new :type, :height, :time
    end

    private

      def magicseaweed
        MagicSeaweed::ForecastRequest.new(ENV['MSW_KEY'], @spot).response.mapper
      end

      # def windfinder
      #
      # end

      def tides(days)
        Admiralty::ForecastRequest.new(days).response.mapper
      end

      def sunrise_sunset(days)
        days.each { |day| SunriseSunset::ForecastRequest.new(@spot, day).response.mapper }
      end
  end

end
