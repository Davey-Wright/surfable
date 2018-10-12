FactoryBot.define do
  factory :session do
    association :spot, factory: :spot, strategy: :build
    name { 'Longboard greasing' }
    board_type { ['longboard'] }

    factory :session_with_conditions do
      after(:build) do |session|
        create(:conditions, session: session)
      end
    end
  end
end
