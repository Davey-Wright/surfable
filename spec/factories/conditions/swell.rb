FactoryBot.define do
  factory :swell_conditions, class: Condition::Swell do
    association :spot, factory: :spot, strategy: :build
    rating { 5 }
    min_height { 5 }
    max_height { nil }
    min_period { 10 }
    direction { ['w', 'sw', 's'] }
  end
end
