# units in meters, mph, seconds

surf_conditions: {
  board_type: ['shortboard', 'longboard', 'funboard', 'fish', 'foamy', 'mini-mal', 'SUP']
  average: {
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
  },
  good: {
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
}
