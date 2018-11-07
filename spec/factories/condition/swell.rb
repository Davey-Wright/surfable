FactoryBot.define do
  factory :conditions_swell, class: Condition::Swell do
    association :condition, factory: :condition, strategy: :build
    min_height { 5 }
    max_height { nil }
    min_period { 10 }
    direction { ['w', 'sw', 's'] }
  end
end
