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
  user.spots.create({
    name: 'Hardies Bay',
    wave_break_type: ['beach', 'reef'],
    wave_shape: ['crumbling', 'steep'],
    wave_length: ['short', 'average'],
    wave_speed: ['average'],
    wave_direction: ['left', 'right'],
    sessions_attributes: [
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
    ]
  })
end

create_spots_for user1
create_spots_for user2
