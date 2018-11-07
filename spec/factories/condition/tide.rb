FactoryBot.define do
  factory :conditions_tide, class: Condition::Tide do
    association :condition, factory: :condition, strategy: :build
    position_low_high { [3, 0] }
    position_high_low { [0, -3] }
    size { ['all'] }
  end
end
