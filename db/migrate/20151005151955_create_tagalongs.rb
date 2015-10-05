class CreateTagalongs < ActiveRecord::Migration
  def change
    create_table :tagalongs do |t|
      t.integer :user_id
      t.integer :post_id
      t.boolean :showed_up

      t.timestamps null: false
    end
  end
end
