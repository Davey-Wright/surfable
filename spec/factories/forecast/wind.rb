FactoryBot.define do
  factory :wind do
    hour { nil }
    speed { 15 }
    gusts { 20 }
    average_speed { 16 }
    direction { 90 }
  end
end
