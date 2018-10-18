{
  hours: [
    {
      swell: {
        height: float,
        period: integer
        direction_deg: integer,
        direction_dir: string,
      },
      tide: {
        type: string,
        time: text,
        height: float
      },
      wind: {
        direction_deg: integer,
        direction_dir: string,
        speed: integer,
        gusts: integer
      }
    }
  ]
}

{
  conditions: {
    swell: {
      min_height: f_height >= min_height
      max_height: f_height <= max_height
      min_period: f_period >= min_period
      direction: f_direction_deg = direction,
    }

    tide: {
      position: {
        min_height: f_height >= min_height,
        max_height: f_height <= max_height
      }
      size: {
        basic: ['small', 'medium', 'large'],
        max_height: float
      }
    }

    wind: {
      direction: f_direction_deg = direction,
      speed: speed <= f_speed
      gusts = speed <= (f_gusts - f_speed) / 10 + f_speed
    }
  }
}