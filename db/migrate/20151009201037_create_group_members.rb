class CreateGroupMembers < ActiveRecord::Migration
  def change
    create_table :group_members do |t|
      t.integer :groupId
      t.integer :userId

      t.timestamps null: false
    end
  end
end
