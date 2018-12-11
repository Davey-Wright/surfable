class CreateConditionWinds < ActiveRecord::Migration[5.2]
  def change
    create_table :condition_winds do |t|
      t.string :name, default: [], array: true
      t.string :direction, default: [], array: true
      t.integer :speed, default: [], array: true
      t.timestamps
    end
    add_reference :condition_winds, :condition
  end
end
