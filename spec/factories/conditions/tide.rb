FactoryBot.define do
  factory :tide_conditions, class: Condition::Tide do
    association :spot, factory: :spot, strategy: :build
    rating { 5 }
    rising { [1, 2, 3] }
    dropping { [1, 2, 3] }
    size { ['all'] }
  end
end
