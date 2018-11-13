FactoryBot.define do
  factory :condition, class: Condition::Condition do
    association :spot, factory: :spot, strategy: :build
    name { 'Morfa' }
    board_type { ['shortboard'] }
    factory :conditions do
      after(:build) do |conditions|
        build(:conditions_swell, condition: conditions)
        build(:conditions_tide, condition: conditions)
        build(:conditions_wind, condition: conditions)
      end
    end
  end
end
