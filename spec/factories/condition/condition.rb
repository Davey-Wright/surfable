FactoryBot.define do
  factory :condition, class: Condition::Condition do
    association :session, factory: :session, strategy: :build
    # association :swell, factory: :swell, strategy: :build
    # association :tide, factory: :tide, strategy: :build
    # association :wind, factory: :wind, strategy: :build
  end
end
