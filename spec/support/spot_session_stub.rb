def spot_session_stub
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
        position_low_high: [2, -1],
        position_high_low: [3, 0],
        size: []
      },
      wind_attributes: {
        direction: ['n', 'nw', 'w'],
        speed: 10
      }
    }
  }
end
