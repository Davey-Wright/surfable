FactoryBot.define do
  factory :spot do
    user_id { nil }
    name { 'Hardies Bay' }
    wave_break_type { 'beach' }
    wave_shape { ['crumbling', 'steep'] }
    wave_length { ['short', 'average'] }
    wave_speed { ['slow', 'average'] }
    wave_direction { ['left', 'right'] }
  end
end
