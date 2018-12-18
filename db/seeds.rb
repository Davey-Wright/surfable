demo_user = User.create({
  email: 'surfable@demo.com',
  password: 'demosender',
  first_name: 'Rikter',
  last_name: 'Sender',
})

demo_user.spots.create({
  name: 'Rest Bay',
  latitude: '51.489510',
  longitude: '-3.726244',
  wave_break_type: ['beach'],
  wave_shape: ['crumbling'],
  wave_length: ['average'],
  wave_speed: ['average'],
  wave_direction: ['left', 'right']
})

demo_user.spots.create({
  name: 'Ogmore River Mouth',
  latitude: '51.470546',
  longitude: '-3.640436',
  wave_break_type: ['beach', 'point'],
  wave_shape: ['steep', 'hollow'],
  wave_length: ['average', 'long'],
  wave_speed: ['average', 'fast'],
  wave_direction: ['right']
})

demo_user.spots.create({
  name: 'Southerndown',
  latitude: '51.445826',
  longitude: '-3.605846',
  wave_break_type: ['beach'],
  wave_shape: ['crumbling'],
  wave_length: ['average'],
  wave_speed: ['average'],
  wave_direction: ['left', 'right']
})

demo_user.spots.create({
  name: 'Llanttwit Major',
  latitude: '51.396031',
  longitude: '-3.501640',
  wave_break_type: ['reef', 'point'],
  wave_shape: ['steep', 'hollow'],
  wave_length: ['average', 'long'],
  wave_speed: ['average', 'fast'],
  wave_direction: ['right']
})





def create_conditions_for(spot)
  spot.swell_conditions.create({
      rating: 4,
      min_height: 4,
      max_height: nil,
      min_period: 10,
      direction: ['w', 'sw', 's']
    })

  spot.tide_conditions.create({
      rating: 3,
      rising: [1, 2, 3],
      dropping: [1, 2, 3],
      size: [5, 6, 7, 8]
    })

  spot.wind_conditions.create({
      rating: 5,
      name: ['offshore'],
      direction: ['w', 'sw', 's'],
      speed: 13
    })
end
