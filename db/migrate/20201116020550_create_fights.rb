class CreateFights < ActiveRecord::Migration[6.0]
  def change
    create_table :fights do |t|
      t.integer :user_id,   null: true
      t.integer :target_id, null: true
      t.timestamps
    end
  end
end
