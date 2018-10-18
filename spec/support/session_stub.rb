def session_stub
  {
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
          min_height: 5,
          max_height: 10
        },
        size: []
      },
      wind_attributes: {
        direction: ['n', 'nw', 'w'],
        speed: 10
      }
    }
  }
end
