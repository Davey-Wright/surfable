class CreateSpots < ActiveRecord::Migration[5.2]
  def change
    create_table :spots do |t|
      t.string 'name'
      t.string 'wave_break_type',  default: [],  array: true
      t.string 'wave_shape',      default: [],  array: true
      t.string 'wave_length',     default: [],  array: true
      t.string 'wave_speed',      default: [],  array: true
      t.string 'wave_direction',  default: [],  array: true
      t.belongs_to 'user', index: true
      t.timestamps
    end
  end
end
