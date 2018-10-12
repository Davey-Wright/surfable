FactoryBot.define do
  factory :condition, class: Condition::Condition do
    association :session, factory: :session, strategy: :build
    factory :conditions do
      after(:build) do |conditions|
        create(:swell, condition: conditions)
        create(:tide, condition: conditions)
        create(:wind, condition: conditions)
      end
    end
  end
end
