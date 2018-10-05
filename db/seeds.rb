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

def add_spot_sessions(user)
  user.spots.each do |spot|
    spot.sessions.create({
      name: 'Logging session'
    })
  end
end

def add_session_conditions(user)
  user.spots.each do |spot|
    spot.sessions.each do |session|
      binding.pry
      session.create_conditions
    end
  end
end

def create_spots(user)
  user.spots.create({
    name: "#{ user.first_name }'s spot",
    wave_break_type: ['beach', 'reef'],
    wave_shape: ['crumbling', 'steep'],
    wave_length: ['short', 'average'],
    wave_speed: ['average'],
    wave_direction: ['left', 'right']
  })
  add_spot_sessions user
  add_session_conditions user
end

create_spots user1
create_spots user2
