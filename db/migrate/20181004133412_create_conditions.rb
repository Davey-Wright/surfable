class CreateConditions < ActiveRecord::Migration[5.2]
  def change
    create_table :conditions do |t|
      t.jsonb :tide, default: '{}', index: true
      t.jsonb :wind, default: '{}', index: true
      t.jsonb :wave, default: '{}', index: true
      t.references :session, index: true
      t.timestamps
    end
  end
end
