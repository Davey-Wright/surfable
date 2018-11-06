module Forecast
  class Tide
    attr_accessor :day, :high, :low, :size

    def initialize(day, data)
      @day = day
      @high = get_tides(data, 'high')
      @low = get_tides(data, 'low')
      @size = set_tide_size
    end

    private

      def set_tide_size
        height = (high.first[:height] + high.last[:height]) / 2
        if height < 7
          return 'small'
        elsif height < 8.5
          return 'average'
        elsif height < 9.5
          return 'big'
        else
          return 'massive'
        end
      end

      def get_tides(data, type)
        tides = data.select { |t| t['type'] == type }
        tides.map { |t| { time: t['time'], height: t['height'].round(2) } }
      end

  end
end
