FactoryBot.define do
  factory :conditions_tide, class: Condition::Tide do
    association :condition, factory: :condition, strategy: :build
    position_low_high {}
    position_high_low {}
    size { ['all'] }
  end
end
