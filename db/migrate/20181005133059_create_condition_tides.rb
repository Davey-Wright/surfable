class CreateConditionTides < ActiveRecord::Migration[5.2]
  def change
    create_table :condition_tides do |t|
      t.float :position_min, default: 0
      t.float :position_max, default: 100
      t.jsonb :size, default: [], array: true
      t.timestamps
    end
    add_reference :condition_tides, :condition
  end
end
