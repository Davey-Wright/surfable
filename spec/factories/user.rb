FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "saltydog#{n}@test.com"
    end
    password {'saltysender'}
    first_name {'salty'}
    last_name {'dog'}
  end
end
