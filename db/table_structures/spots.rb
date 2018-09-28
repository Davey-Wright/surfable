# units of measurment
#  - metres, mph

spot: {
  name: string,
  wave_break_type: ['beach', 'point', 'reef'],
  wave_shape: ['crumbling', 'steep', 'hollow'],
  wave_length: ['short', 'average', 'long'],
  wave_speed: ['slow', 'average', 'fast'],
  wave_direction: ['left', 'right'],
  surf_conditions: [
    {
      board_type: ['shortboard', 'longboard', 'funboard', 'fish', 'foamy', 'mini-mal', 'SUP']
      average: conditions,
      good: conditions
    }
  ]
}

conditions: {
  tide: {
    position: {
      basic: ['low', 'mid', 'high'],
      advanced: {
        from: integer,
        to: integer
      }
    }
    movement: ['rising', 'slack', 'dropping'],
    size: {
      basic: ['small', 'medium', 'large'],
      advanced: integer
    }
  },
  wind: {
    good: {
      direction: ['n', 'ne', 'e', 'se', 's', 'sw', 'w', 'nw'],
      speed: ['<5', '<10', '<15', '<20', '<30', '<40']
    }
  }
  wave: {
    min_period: integer,
    direction: ['n', 'ne', 'e', 'se', 's', 'sw', 'w', 'nw'],
    min_height: integer,
    max_height: integer
  }
}
