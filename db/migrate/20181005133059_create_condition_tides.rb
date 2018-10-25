class CreateConditionTides < ActiveRecord::Migration[5.2]
  def change
    create_table :condition_tides do |t|
      t.integer :position_low_high, default: [], array: true
      t.integer :position_high_low, default: [], array: true
      t.string :size, default: [], array: true
      t.timestamps
    end
    add_reference :condition_tides, :condition
  end
end
