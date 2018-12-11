FactoryBot.define do
  factory :condition_tide, class: Condition::Tide do
    association :condition, factory: :conditions, strategy: :build
    rating { 5 }
    rising { [1, 2, 3] }
    dropping { [1, 2, 3] }
    size { ['all'] }
  end
end
