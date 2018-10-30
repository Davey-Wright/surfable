module Forecast
  class Day
    attr_reader :forecast, :date, :hours, :tides,
      :sunrise, :sunset, :first_light, :last_light

    def initialize(forecast, data)
      @forecast = forecast
      @date = data['date']
      @hours = data['hours'].map { |hour| Hour.new(self, hour) }
      @tides = Tide.new(data['tides'])
      @sunrise = set_time_for('sunrise', data)
      @sunset = set_time_for('sunset', data)
      @first_light = set_time_for('civil_twilight_begin', data)
      @last_light = set_time_for('civil_twilight_end', data)
    end

    private

    def set_time_for(key, data)
      time = data['sunrise_sunset']['results'][key]
      Time.use_zone('London') { Time.zone.parse(time).strftime('%H:%M') }
    end

  end
end
