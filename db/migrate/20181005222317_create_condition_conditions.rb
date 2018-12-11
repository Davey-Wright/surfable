class CreateConditionConditions < ActiveRecord::Migration[5.2]
  def change
    create_table :condition_conditions do |t|
      t.string :rating
      t.string :name, null: false
      t.string :board_selection, default: [], array: true
      t.timestamps
      t.references :spot, index: true, foreign_key: { on_delete: :cascade }
    end
    # add_reference :condition_conditions, :spot, foreign_key: true, on_delete: :cascade
  end
end
