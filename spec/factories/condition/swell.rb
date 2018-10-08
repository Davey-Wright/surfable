FactoryBot.define do
  factory :swell, class: Condition::Swell do
    association :condition, factory: :condition, strategy: :build
    min_height { 3 }
    max_height { 15 }
    min_period { 9 }
    direction { ['w', 'sw', 's'] }
  end
end
