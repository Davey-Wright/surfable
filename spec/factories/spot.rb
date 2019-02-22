FactoryBot.define do
  factory :spot do
    association :user, factory: :user, strategy: :build
    name { 'Hardies Bay' }
    wave_break_type { ['beach'] }
    wave_shape { ['crumbling', 'steep'] }
    wave_length { ['short', 'average'] }
    wave_speed { ['slow', 'average'] }
    wave_direction { ['left', 'right'] }

    factory :spot_with_conditions do
      after(:create) do |spot|
        2.times do |n|
          create(:swell_conditions, spot: spot, rating: n + 4)
          create(:wind_conditions, spot: spot, rating: n + 2)
        end
        create(:tide_conditions, {
          spot: spot,
          rising: [0, 1, 2, 3],
          dropping: [],
          size: [7, 8, 9]
          })
        create(:swell_conditions, {
          spot: spot,
          rating: 1,
          min_height: 1,
          max_height: nil,
          min_period: 4,
          direction: ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W']
          })
        create(:wind_conditions, {
          spot: spot,
          rating: 1,
          name: ['onshore'],
          max_speed: 50,
          direction: ['N', 'NE', 'SE', 'S', 'SW', 'W']
          })
      end
    end

  end
end
