FactoryBot.define do
  factory :session do
    association :spot, factory: :spot, strategy: :build
    name { 'Longboard greasing' }
    board_type { ['longboard'] }
  end
end
