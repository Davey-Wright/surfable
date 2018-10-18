FactoryBot.define do
  factory :tide, class: Condition::Tide do
    association :condition, factory: :condition, strategy: :build
    position { {
      min_height: 5,
      max_height: 12
    } }
    size { ['small', 'medium', 'large'] }
  end
end
