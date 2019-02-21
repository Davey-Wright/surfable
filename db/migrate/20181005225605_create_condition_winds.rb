class CreateConditionWinds < ActiveRecord::Migration[5.2]
  def change
    create_table :condition_winds do |t|
      t.integer :rating, null: false
      t.string :name, default: [], array: true
      t.string :direction, default: [], array: true
      t.integer :max_speed
      t.belongs_to :spot, index: true
      t.timestamps
    end
  end
end
