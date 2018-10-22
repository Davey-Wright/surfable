FactoryBot.define do
  factory :conditions_tide, class: Condition::Tide do
    association :condition, factory: :condition, strategy: :build
    position { {
      low_high: 2,
      high_low: nil
    } }
    size { ['medium'] }
  end
end
