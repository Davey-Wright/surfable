class CreateConditionTides < ActiveRecord::Migration[5.2]
  def change
    create_table :condition_tides do |t|
      t.float :position_low_high, null: false, default: [], array: true
      t.float :position_high_low, null: false, default: [], array: true
      t.string :size, default: [], null: false, array: true
      t.timestamps
    end
    add_reference :condition_tides, :condition
  end
end
