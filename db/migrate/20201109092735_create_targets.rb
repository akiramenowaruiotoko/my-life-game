class CreateTargets < ActiveRecord::Migration[6.0]
  def change
    create_table :targets do |t|
      t.string  :content, null: false
      t.date :target_date, null: false
      t.boolean :achieve, null: false, default: false
      t.timestamps
      t.references :user, foreign_key: true
    end
  end
end