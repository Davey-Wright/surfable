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

def create_spots(user)
  3.times do |n|
    user.spots.create({
      name: "#{ user.first_name }'s spot ##{ n }",
      wave_break_type: ['beach', 'reef'],
      wave_shape: ['crumbling', 'steep'],
      wave_length: ['short', 'average'],
      wave_speed: ['average'],
      wave_direction: ['left', 'right']
    })
  end
end

create_spots user1
create_spots user2
