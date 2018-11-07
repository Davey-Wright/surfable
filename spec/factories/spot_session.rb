FactoryBot.define do
  factory :spot_session do
    association :spot, factory: :spot, strategy: :build
    name { 'Morfa' }
    board_type { ['shortboard'] }

    factory :spot_session_with_conditions do
      after(:build) do |session|
        create(:conditions, spot_session: session)
      end
    end
  end
end
