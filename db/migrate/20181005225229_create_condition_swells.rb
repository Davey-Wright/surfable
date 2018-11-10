class CreateConditionSwells < ActiveRecord::Migration[5.2]
  def change
    create_table :condition_swells do |t|
      t.float :min_height, null: false
      t.float :max_height
      t.integer :min_period, null: false
      t.string :direction, null: false, default: [], array: true
      t.timestamps
    end
    add_reference :condition_swells, :condition
  end
end
