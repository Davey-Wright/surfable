FactoryBot.define do
  factory :spot do
    association :user, factory: :user, strategy: :build
    name { 'Hardies Bay' }
    wave_break_type { 'beach' }
    wave_shape { ['crumbling', 'steep'] }
    wave_length { ['short', 'average'] }
    wave_speed { ['slow', 'average'] }
    wave_direction { ['left', 'right'] }

    factory :spot_with_session do
      after(:build) do |spot|
        create(:spot_session, spot: spot)
      end
    end

    factory :spot_with_session_conditions do
      after(:build) do |spot|
        create(:spot_session_with_conditions, spot: spot)
      end
    end
  end
end
