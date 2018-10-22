FactoryBot.define do
  factory :conditions_wind, class: Condition::Wind do
    association :condition, factory: :condition, strategy: :build
    direction { ['ne', 'e', 'se'] }
    speed { 20 }
  end
end
