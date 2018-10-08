FactoryBot.define do
  factory :tide, class: Condition::Tide do
    association :condition, factory: :condition, strategy: :build
    position { {
      min: 5,
      max: 12,
      basic: ['low', 'mid', 'high']
    } }
    movement { ['rising', 'slack', 'dropping'] }
    size { {
      min: 10,
      max: 12,
      basic: ['small', 'medium', 'large']
    } }
  end
end
