FactoryBot.define do
  factory :conditions, class: Condition::Condition do
    association :spot, factory: :spot, strategy: :create
    name { 'Morfa' }
    board_selection { ['shortboard'] }
    after(:build) do |conditions|
      build(:conditions_swell, condition: conditions)
      build(:conditions_tide, condition: conditions)
      build(:conditions_wind, condition: conditions)
    end
  end
end
