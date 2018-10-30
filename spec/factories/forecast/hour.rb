FactoryBot.define do
  factory :hour, class: 'Forecast::Hour' do
    day { nil }
    sequence(:value) { |h| h }
    swell { FactoryBot.build(:swell) }
    wind { FactoryBot.build(:wind) }
  end
end
