class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :surf_sessions do |t|
      t.string :name, null: false
      t.string :board_type, default: [], array: true, null: false
      t.belongs_to :spot, index: true
      t.timestamps
    end
  end
end
