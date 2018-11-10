FactoryBot.define do
  factory :condition, class: Condition::Condition do
    association :spot_session, factory: :spot_session, strategy: :build
    factory :conditions do
      after(:build) do |conditions|
        build(:conditions_swell, condition: conditions)
        build(:conditions_tide, condition: conditions)
        build(:conditions_wind, condition: conditions)
      end
    end
  end
end
