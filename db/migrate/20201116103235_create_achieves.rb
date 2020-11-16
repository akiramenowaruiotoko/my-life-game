class CreateAchieves < ActiveRecord::Migration[6.0]
  def change
    create_table :achieves do |t|
      t.integer  :target_id
      t.timestamps
    end
  end
end
