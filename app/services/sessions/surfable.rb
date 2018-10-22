module Sessions
  class Surfable < ApplicationService
    def initialize(user, forecast)
      @user_conditions = user
      @day_forecast = forecast
    end

    def call
      swell && tide && wind ? true : false
    end

private

    def swell
      user = @user_conditions.swell
      forecast = @day_forecast.swell
      return false if user.min_height >= forecast.height
      return false if user.max_height <= forecast.height
      return false if user.min_period >= forecast.period
      return false if direction(user.direction, forecast.direction)
      return true
    end

    def tide
      user = @user_conditions.tide
      forecast = @day_forecast.tide
      # return false if user.position_min >= forecast.height
      # return false if user.position_max >= forecast.height
      # return false if user.basic...
      #
      return true
    end

    def wind
      user = @user_conditions.wind
      forecast = @day_forecast.wind
      return false if user.speed <= average_wind_speed(forecast)
      return false if direction(user.direction, forecast.direction)
      return true
    end

    def average_wind_speed(forecast)
      (forecast.gusts - forecast.speed) / 5 + forecast.speed
    end

    def direction(user_direction, direction)
      forecast_direction = case direction
        when (0..22) || (337..360)
          'n'
        when 23..68
          'ne'
        when 69..112
          'e'
        when 113..157
          'se'
        when 158..202
          's'
        when 203..247
          'sw'
        when 248..292
          'w'
        when 293..337
          'nw'
      end
      user_direction.exclude? forecast_direction ? true : false
    end

  end
end
