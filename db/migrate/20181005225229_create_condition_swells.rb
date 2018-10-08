class CreateConditionSwells < ActiveRecord::Migration[5.2]
  def change
    create_table :condition_swells do |t|
      t.integer :min_height
      t.integer :max_height
      t.integer :min_period
      t.string :direction, default: [], array: true
      t.timestamps
    end
    add_reference :condition_swells, :condition
  end
end
