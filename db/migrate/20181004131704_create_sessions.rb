class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.string :name
      t.string :board_type, default: [],  array: true
      t.references :spot, index: true
      t.timestamps
    end
  end
end
