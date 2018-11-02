module Forecast
  class Swell < ApplicationRecord
    belongs_to :day

    attr_reader :hour, :height, :period, :direction

    def initialize(data)
      @hour = data['hour']
      @height = data['height']
      @period = data['period']
      @direction = data['direction']
    end
  end
end


# class SwellMapper
#
#   def forecast_swell_data
#     {
#       hour: nil,
#       height: shaka.css('.data-waveheight .units-wh').text.to_f,
#       period: shaka.css('.data-wavefreq').text.to_i
#     }
#   end
#
# end
