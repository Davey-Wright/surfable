user1 = User.create({
  email: 'saltydog@test.com',
  password: 'saltysender',
  first_name: 'Salty',
  last_name: 'Dog',
})

user2 = User.create({
  email: 'riktersender@test.com',
  password: 'riktersender',
  first_name: 'Rikter',
  last_name: 'Sender',
})


def create_spots_for(user)
  5.times do
    user.spots.create({
      name: 'Morfa',
      wave_break_type: ['beach', 'reef'],
      wave_shape: ['crumbling', 'steep'],
      wave_length: ['short', 'average'],
      wave_speed: ['average'],
      wave_direction: ['left', 'right']
    })
  end
end

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


create_spots_for user1

user1.spots.each do |spot|
  (1 + rand(5)).times do
    create_conditions_for spot
  end
end
