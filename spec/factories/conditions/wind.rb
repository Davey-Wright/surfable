FactoryBot.define do
  factory :wind_conditions, class: Condition::Wind do
    association :spot, factory: :spot, strategy: :build
    rating { 4 }
    name { ['onshore'] }
    direction { ['n', 'ne', 'e'] }
    speed { 20 }
  end
end
