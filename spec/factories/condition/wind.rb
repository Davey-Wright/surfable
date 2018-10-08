FactoryBot.define do
  factory :wind, class: Condition::Wind do
    association :condition, factory: :condition, strategy: :build
    direction { ['n', 'nw', 'w'] }
    speed { 10 }
  end
end
