class CreateTargets < ActiveRecord::Migration[6.0]
  def change
    create_table   :targets do |t|
      t.string     :content,     null: false
      t.date       :target_date, null: false
      t.integer    :user_id,     null: false
      t.timestamps
    end
  end
end