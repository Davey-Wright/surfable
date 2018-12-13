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
        create(:swell_conditions, spot: spot)
        create(:tide_conditions, spot: spot)
        create(:wind_conditions, spot: spot)
      end
    end

  end
end
