class CreateFights < ActiveRecord::Migration[6.0]
  def change
    create_table :fights do |t|
      t.integer :user_id
      t.integer :target_id
      t.timestamps
    end
  end
end
