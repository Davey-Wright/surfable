belongs_to :surf_conditions

conditions = {
  tide,
  wind,
  wave
}

tide = {
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
}

wave = {
  min_period: integer,
  direction: ['n', 'ne', 'e', 'se', 's', 'sw', 'w', 'nw'],
  min_height: integer,
  max_height: integer
}

wind = {
  direction: ['n', 'ne', 'e', 'se', 's', 'sw', 'w', 'nw'],
  speed: integer
  wind_speed_options ['<5', '<10', '<15', '<20', '<30', '<40']
}
