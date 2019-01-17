demo_user = User.create({
  email: 'surfable@demo.com',
  password: 'demosender',
  first_name: 'Rikter',
  last_name: 'Sender',
})


# Porthcawl
porthcawl = demo_user.spots.create({
  name: 'Rest Bay',
  latitude: '51.489510',
  longitude: '-3.726244',
  wave_break_type: ['beach'],
  wave_shape: ['crumbling'],
  wave_length: ['average'],
  wave_speed: ['average'],
  wave_direction: ['left', 'right']
  })

porthcawl.create_tide({
  rising: [1, 2, 3, 4, 5],
  dropping: [1, 2, 3, 4, 5],
  size: [5, 6, 7, 8]
  })

porthcawl.swells.create({
  rating: 1,
  min_height: 1,
  max_height: nil,
  min_period: 1,
  direction: ['n', 'ne', 'e', 's', 'sw', 'w', 'nw']
  })

porthcawl.swells.create({
  rating: 4,
  min_height: 3,
  max_height: nil,
  min_period: 10,
  direction: ['w', 'sw', 's']
  })

porthcawl.swells.create({
  rating: 5,
  min_height: 6,
  max_height: nil,
  min_period: 12,
  direction: ['w', 'sw', 's']
  })

porthcawl.winds.create({
  rating: 4,
  name: ['onshore'],
  direction: ['w', 'sw', 's'],
  speed: 5
  })

porthcawl.winds.create({
  rating: 5,
  name: ['onshore'],
  direction: ['w', 'sw', 's'],
  speed: 3
  })

porthcawl.winds.create({
  rating: 1,
  name: ['strong onshore'],
  direction: ['n', 'ne', 'e', 's', 'sw', 'w', 'nw'],
  speed: 100
  })

# Ogmore
ogmore = demo_user.spots.create({
  name: 'Ogmore River Mouth',
  latitude: '51.470546',
  longitude: '-3.640436',
  wave_break_type: ['beach', 'point'],
  wave_shape: ['steep', 'hollow'],
  wave_length: ['average', 'long'],
  wave_speed: ['average', 'fast'],
  wave_direction: ['right']
  })

ogmore.create_tide({
  rising: [5, 6],
  dropping: [1, 2],
  size: [7, 8]
  })

ogmore.swells.create({
  rating: 1,
  min_height: 1,
  max_height: nil,
  min_period: 1,
  direction: ['n', 'ne', 'e', 's', 'sw', 'w', 'nw']
  })

ogmore.swells.create({
  rating: 3,
  min_height: 3,
  max_height: nil,
  min_period: 10,
  direction: ['w', 'sw', 's']
  })

ogmore.swells.create({
  rating: 4,
  min_height: 5,
  max_height: nil,
  min_period: 12,
  direction: ['w', 'sw', 's']
  })

ogmore.swells.create({
  rating: 5,
  min_height: 7,
  max_height: nil,
  min_period: 12,
  direction: ['w', 'sw', 's']
  })

ogmore.winds.create({
  rating: 1,
  name: ['strong onshore'],
  direction: ['n', 'ne', 'e', 's', 'sw', 'w', 'nw'],
  speed: 100
  })

ogmore.winds.create({
  rating: 4,
  name: ['onshore'],
  direction: ['w', 'sw', 'nw'],
  speed: 5
  })

ogmore.winds.create({
  rating: 5,
  name: ['onshore'],
  direction: ['w', 'sw', 'nw'],
  speed: 3
  })

ogmore.winds.create({
  rating: 5,
  name: ['offshore'],
  direction: ['ne', 'e', 'se', 's'],
  speed: 15
  })


# Southerndown
southerndown = demo_user.spots.create({
  name: 'Southerndown',
  latitude: '51.445826',
  longitude: '-3.605846',
  wave_break_type: ['beach'],
  wave_shape: ['crumbling'],
  wave_length: ['average'],
  wave_speed: ['average'],
  wave_direction: ['left', 'right']
  })

southerndown.create_tide({
  rising: [4, 5, 6],
  dropping: [1, 2, 3],
  size: [5, 6, 7, 8, 9]
  })

southerndown.swells.create({
  rating: 1,
  min_height: 1,
  max_height: nil,
  min_period: 1,
  direction: ['n', 'ne', 'e', 's', 'sw', 'w', 'nw']
  })

southerndown.swells.create({
  rating: 3,
  min_height: 3,
  max_height: nil,
  min_period: 10,
  direction: ['w', 'sw', 's']
  })

southerndown.swells.create({
  rating: 5,
  min_height: 6,
  max_height: nil,
  min_period: 12,
  direction: ['w', 'sw', 's']
  })

southerndown.winds.create({
  rating: 4,
  name: ['onshore'],
  direction: ['w', 'sw', 's'],
  speed: 5
  })

southerndown.winds.create({
  rating: 5,
  name: ['onshore'],
  direction: ['w', 'sw', 's'],
  speed: 3
  })

southerndown.winds.create({
  rating: 5,
  name: ['offshore'],
  direction: ['ne', 'e', 'se'],
  speed: 20
  })

southerndown.winds.create({
  rating: 1,
  name: ['strong onshore'],
  direction: ['n', 'ne', 'e', 's', 'sw', 'w', 'nw'],
  speed: 100
  })

# Llanttwit
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
  spot.swells.create({
      rating: 4,
      min_height: 4,
      max_height: nil,
      min_period: 10,
      direction: ['w', 'sw', 's']
    })

  spot.tide.create({
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
