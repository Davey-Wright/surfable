FactoryBot.define do
  factory :conditions, class: Condition::Condition do
    association :spot, factory: :spot, strategy: :create
    name { 'Morfa' }
    board_selection { ['shortboard'] }
    after(:build) do |condition|
      build(:condition_swell, condition: condition)
      build(:condition_tide, condition: condition)
      condition.winds << build(:condition_wind, condition: condition)
    end
  end
end
