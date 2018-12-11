FactoryBot.define do
  factory :condition_wind, class: Condition::Wind do
    association :condition, factory: :conditions, strategy: :build
    name { ['onshore'] }
    direction { ['n', 'ne', 'e'] }
    speed { ['< 20'] }
  end
end
