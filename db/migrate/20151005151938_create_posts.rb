class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :owner_id
      t.string :title
      t.string :topic
      t.datetime :start
      t.integer :expected_duration_hr
      t.integer :expected_duration_min
      t.text :details
      t.boolean :cancelled
      t.integer :estimated_difficulty

      t.timestamps null: false
    end
  end
end
