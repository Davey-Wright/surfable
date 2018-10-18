{
  conditions: {
    swell: {
      min_height: float,
      max_height: float
      min_period: integer,
      direction: ['n', 'ne', 'e', 'se', 's', 'sw', 'w', 'nw'],
    }

    tide: {
      position: {
        low_high: float,
        high_low: float
      },
      size: ['small', 'average', 'large']
    }

    wind: {
      direction: ['n', 'ne', 'e', 'se', 's', 'sw', 'w', 'nw'],
      speed: integer
    }
  }
}

wind.speed.options = [5, 10, 15, 20, 30, 40]

  size: {
    basic: ['small', 'medium', 'large']
  }
}



tide.size = {
  small = < 7.25
  medium = 7.25 - 8.75
  high = > 8.75
}
