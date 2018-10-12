def spot_stub
  {
    name: 'Morfa',
    wave_break_type: ['beach', 'reef'],
    wave_shape: ['crumbling', 'steep'],
    wave_length: ['short', 'average'],
    wave_speed: ['average'],
    wave_direction: ['left', 'right'],
    sessions_attributes: [ {
      name: 'Longboard greasing',
      board_type: ['longboard'],
      conditions_attributes: {
        swell_attributes: {
          min_height: 3,
          max_height: 15,
          min_period: 9,
          direction: ['w', 'sw', 's']
        },
        tide_attributes: {
          position: {
            min: 5,
            max: 12,
            basic: ['low', 'mid', 'high']
          },
          movement: ['rising', 'slack', 'dropping'],
          size: {
            min: 10,
            max: 12,
            basic: ['small', 'medium', 'large']
          }
        },
        wind_attributes: {
          direction: ['n', 'nw', 'w'],
          speed: 10
        }
      }
    } ]
  }
end
