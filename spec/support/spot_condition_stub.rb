def spot_condition_stub
  {
    name: 'Morfa',
    board_selection: ['shortboard'],
    swell_attributes: {
      min_height: 4,
      max_height: nil,
      min_period: 10,
      direction: ['w', 'sw', 's']
    },
    tide_attributes: {
      position_low_high: [4, 0],
      position_high_low: [0, -4],
      size: ['all']
    },
    wind_attributes: {
      direction: ['n', 'nw', 'w'],
      speed: 10
    }
  }
end
