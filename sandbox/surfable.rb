surfable = {
  conditions: {
    swell: {
      min_height: f_height >= min_height
      max_height: f_height <= max_height
      min_period: f_period >= min_period
      direction: f_direction_deg = direction,
    }

    tide: {
      position: {
        low_high: f_height >= min_height,
        high_low: f_height <= max_height
      }
      size: ['small', 'medium', 'large'],
    }

    wind: {
      direction: f_direction_deg = direction,
      speed: speed <= f_speed
      gusts = speed <= (f_gusts - f_speed) / 10 + f_speed
    }
  }
}


Methods needed to convert
tide.position = two sliders with 5 hours between (low -> high), (high -> low)
tide.size = [small: < 7, average: > small && < large, large: > 8.5]

tide.position.low_high
tide.position.high_low
tide.size []
