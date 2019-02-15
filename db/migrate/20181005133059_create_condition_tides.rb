class CreateConditionTides < ActiveRecord::Migration[5.2]
  def change
    create_table :condition_tides do |t|
      t.integer :rising, default: [], array: true
      t.integer :dropping, default: [], array: true
      t.integer :size, default: [], array: true
      t.belongs_to :spot, index: true
      t.timestamps
    end
  end
end
