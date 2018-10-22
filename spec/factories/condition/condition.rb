FactoryBot.define do
  factory :condition, class: Condition::Condition do
    association :session, factory: :session, strategy: :build
    factory :conditions do
      after(:build) do |conditions|
        create(:conditions_swell, condition: conditions)
        create(:conditions_tide, condition: conditions)
        create(:conditions_wind, condition: conditions)
      end
    end
  end
end
