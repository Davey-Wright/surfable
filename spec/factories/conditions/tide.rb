FactoryBot.define do
  factory :condition_tide, class: Condition::Tide do
    association :condition, factory: :conditions, strategy: :build
    position_low_high {}
    position_high_low {}
    size { ['all'] }
  end
end
