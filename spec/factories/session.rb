FactoryBot.define do
  factory :session do
    spot
    name { 'Longboard greasing' }
    board_type { ['longboard'] }
    conditions_attributes { {} }
  end
end
