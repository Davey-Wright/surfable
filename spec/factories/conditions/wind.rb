FactoryBot.define do
  factory :condition_wind, class: Condition::Wind do
    association :condition, factory: :conditions, strategy: :build
    title { 'onshore' }
    direction { [300, 180] }
    speed { 20 }
  end
end
