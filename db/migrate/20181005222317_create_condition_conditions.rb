class CreateConditionConditions < ActiveRecord::Migration[5.2]
  def change
    create_table :condition_conditions do |t|
      t.string :name
      t.string :board_type, default: [], array: true, null: false
      t.belongs_to :spot, index: true
      t.timestamps
    end
    # add_reference :condition_conditions, :spot, foreign_key: true
  end
end
