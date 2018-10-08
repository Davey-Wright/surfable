class CreateConditionConditions < ActiveRecord::Migration[5.2]
  def change
    create_table :condition_conditions do |t|
      t.timestamps
    end
    add_reference :condition_conditions, :session, foreign_key: true
  end
end
