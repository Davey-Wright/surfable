class CreateConditionTides < ActiveRecord::Migration[5.2]
  def change
    create_table :condition_tides do |t|
      t.jsonb :position, default: {}, null: false
      t.jsonb :size, default: [], array: true
      t.timestamps
    end
    add_reference :condition_tides, :condition
  end
end
