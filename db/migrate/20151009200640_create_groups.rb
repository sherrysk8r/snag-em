class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.boolean :open_group
      t.string :domain
      t.boolean :company
      t.string :picture

      t.timestamps null: false
    end
  end
end
