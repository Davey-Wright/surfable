FactoryBot.define do
  factory :surf_session do
    association :spot, factory: :spot, strategy: :build
    name { 'Longboard greasing' }
    board_type { ['longboard'] }

    factory :surf_session_with_conditions do
      after(:build) do |session|
        create(:conditions, surf_session: session)
      end
    end
  end
end
