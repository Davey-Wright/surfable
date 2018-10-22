FactoryBot.define do
  factory :conditions_swell, class: Condition::Swell do
    association :condition, factory: :condition, strategy: :build
    min_height { 1 }
    max_height { 100 }
    min_period { 10 }
    direction { ['w', 'sw', 's'] }
  end
end
