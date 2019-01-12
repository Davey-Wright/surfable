FactoryBot.define do
  factory :tide_conditions, class: Condition::Tide do
    association :spot, factory: :spot, strategy: :build
    rising { [0, 1, 2, 3] }
    dropping { [0, 1] }
    size { ['all'] }
  end
end
