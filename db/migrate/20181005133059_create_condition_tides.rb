class CreateConditionTides < ActiveRecord::Migration[5.2]
  def change
    create_table :condition_tides do |t|
      t.jsonb :position, default: {}, null: false
      t.jsonb :movement, default: [], array: true
      t.jsonb :size, default: {}, null: false
      t.timestamps
    end
    add_reference :condition_tides, :condition
  end
end
