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
        2.times do
          create(:swell_conditions, spot: spot)
          create(:wind_conditions, spot: spot)
        end
        create(:tide_conditions, {
          spot: spot,
          rating: 5,
          rising: [0, 1, 2, 3],
          dropping: [],
          size: [7, 8, 9]
          })
      end
    end

  end
end
