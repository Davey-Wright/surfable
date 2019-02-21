FactoryBot.define do
  factory :wind_conditions, class: Condition::Wind do
    association :spot, factory: :spot, strategy: :build
    rating { 4 }
    name { ['onshore'] }
    direction { ['nw', 'n', 'w', 'sw'] }
    max_speed { 4 }
  end
end
