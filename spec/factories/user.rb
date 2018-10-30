FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "saltydog#{n}@test.com"
    end
    password {'saltysender'}
    first_name {'salty'}
    last_name {'dog'}

    factory :user_with_spot do
      after(:build) do |user|
        create(:spot, user: user)
      end
    end

    factory :user_with_complete_spot do
      after(:build) do |user|
        create(:spot_with_surf_sessions, user: user)
      end
    end
  end
end
