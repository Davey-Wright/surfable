class CreateConditionSwells < ActiveRecord::Migration[5.2]
  def change
    create_table :condition_swells do |t|
      t.integer :rating, null: false
      t.float :min_height
      t.float :max_height
      t.integer :min_period
      t.string :direction, default: [], array: true
      t.belongs_to :spot, index: true
      t.timestamps
    end
  end
end
