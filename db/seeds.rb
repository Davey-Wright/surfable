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
  size: [5, 6, 7, 8, 9]
  })

porthcawl.swells.create({
  rating: 5,
  min_height: 6,
  max_height: nil,
  min_period: 12,
  direction: ['S', 'SW', 'W', 'NW', 'N']
  })

porthcawl.swells.create({
  rating: 3,
  min_height: 3,
  max_height: nil,
  min_period: 10,
  direction: ['S', 'SW', 'W', 'NW', 'N']
  })

porthcawl.winds.create({
  rating: 5,
  name: ['onshore'],
  max_speed: 5,
  direction: ['NW', 'SE', 'S', 'SW', 'W']
  })

porthcawl.winds.create({
  rating: 3,
  name: ['onshore'],
  max_speed: 10,
  direction: ['NW', 'W', 'SW', 'S']
  })

porthcawl.winds.create({
  rating: 5,
  name: ['offshore'],
  max_speed: 15,
  direction: ['NE', 'E', 'SE' ]
  })

porthcawl.winds.create({
  rating: 3,
  name: ['offshore'],
  max_speed: 30,
  direction: ['N', 'NE', 'E', 'SE' ]
  })

porthcawl.winds.create({
  rating: 3,
  name: ['sideshore'],
  max_speed: 30,
  direction: ['N', 'S']
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
  size: [7, 8, 9]
  })

ogmore.swells.create({
  rating: 5,
  min_height: 6,
  max_height: nil,
  min_period: 12,
  direction: ['S', 'SW', 'W', 'NW']
  })

ogmore.swells.create({
  rating: 3,
  min_height: 3,
  max_height: nil,
  min_period: 10,
  direction: ['S', 'SW', 'W', 'NW']
  })

ogmore.winds.create({
  rating: 5,
  name: ['onshore'],
  max_speed: 5,
  direction: ['NW', 'SW', 'W']
  })

ogmore.winds.create({
  rating: 3,
  name: ['onshore'],
  max_speed: 10,
  direction: ['NW', 'W', 'SW', 'S']
  })

ogmore.winds.create({
  rating: 5,
  name: ['offshore'],
  max_speed: 15,
  direction: ['NE', 'E', 'SE', 'S' ]
  })

ogmore.winds.create({
  rating: 3,
  name: ['offshore'],
  max_speed: 30,
  direction: ['NE', 'E', 'SE', 'S']
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
  rating: 5,
  min_height: 8,
  max_height: nil,
  min_period: 12,
  direction: ['S', 'SW', 'W', 'NW', 'N']
  })

southerndown.swells.create({
  rating: 3,
  min_height: 5,
  max_height: nil,
  min_period: 10,
  direction: ['S', 'SW', 'W', 'NW', 'N']
  })

southerndown.winds.create({
  rating: 5,
  name: ['onshore'],
  max_speed: 5,
  direction: ['NW', 'SE', 'S', 'SW', 'W']
  })

southerndown.winds.create({
  rating: 3,
  name: ['onshore'],
  max_speed: 10,
  direction: ['NW', 'W', 'SW', 'S']
  })

southerndown.winds.create({
  rating: 5,
  name: ['offshore'],
  max_speed: 15,
  direction: ['NE', 'E', 'SE' ]
  })

southerndown.winds.create({
  rating: 3,
  name: ['offshore'],
  max_speed: 30,
  direction: ['N', 'NE', 'E', 'SE' ]
  })

southerndown.winds.create({
  rating: 3,
  name: ['sideshore'],
  max_speed: 30,
  direction: ['N', 'S']
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

#
#
# def create_conditions_for(spot)
#   spot.swells.create({
#       rating: 4,
#       min_height: 4,
#       max_height: nil,
#       min_period: 10,
#       direction: ['S', 'SW', 'W']
#     })
#
#   spot.tide.create({
#       rating: 3,
#       rising: [1, 2, 3],
#       dropping: [1, 2, 3],
#       size: [5, 6, 7, 8]
#     })
#
#   spot.wind_conditions.create({
#       rating: 5,
#       name: ['offshore'],
#       direction: ['S', 'SW', 'W'],
#       speed: 13
#     })
# end
