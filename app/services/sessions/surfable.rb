module Sessions
  class Surfable
    attr_reader :status

    def initialize(conditions, forecast)
      @user_conditions = conditions
      @forecast = forecast
      @status = status
    end

    def status
      @user_conditions - @forecast
    end

    def swell()
      {
        min_height: f_height >= min_height
        max_height: f_height <= max_height
        min_period: f_period >= min_period
        direction: f_direction_deg = direction,
      }
    end

    def tide
      {
        position: {
          min_height: f_height >= min_height,
          max_height: f_height <= max_height
        }
        size: {
          basic: ['small', 'medium', 'large'],
          max_height: float
        }
      }
    end

    def wind
      {
        direction: f_direction_deg = direction,
        speed: speed <= f_speed
        gusts = speed <= (f_gusts - f_speed) / 10 + f_speed
      }
    end

  end
end
