FactoryBot.define do
  factory :day, class: 'Forecast::Day' do
    forecast { nil }
    date { "2018-10-29" }
    hours { 8.times { FactoryBot.build(:hour) } }
    tides { FactoryBot.build(:tide) }
    sunrise { "07:02" }
    sunset { "16:54" }
    first_light { "17:29" }
    last_light { "06:27" }
  end
end
