class CreateConditionTides < ActiveRecord::Migration[5.2]
  def change
    create_table :condition_tides do |t|
      t.float :rising, null: false, default: [], array: true
      t.float :dropping, null: false, default: [], array: true
      t.string :size, default: [], array: true
      t.timestamps
    end
    add_reference :condition_tides, :condition
  end
end
