class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.boolean :private
      t.string :domain

      t.timestamps null: false
    end
  end
end
