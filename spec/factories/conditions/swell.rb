FactoryBot.define do
  factory :condition_swell, class: Condition::Swell do
    association :condition, factory: :conditions, strategy: :build
    min_height { 5 }
    max_height { nil }
    min_period { 10 }
    direction { ['w', 'sw', 's'] }
  end
end
