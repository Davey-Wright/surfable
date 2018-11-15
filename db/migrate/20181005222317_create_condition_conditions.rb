class CreateConditionConditions < ActiveRecord::Migration[5.2]
  def change
    create_table :condition_conditions do |t|
      t.string :name
      t.string :board_selection, default: [], array: true, null: false
      t.timestamps
    end
    add_reference :condition_conditions, :spot, foreign_key: true
  end
end
