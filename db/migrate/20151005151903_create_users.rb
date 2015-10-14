class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :last_name
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :city
      t.string :state
      t.text :about_me
      t.date :date_of_birth
      t.string :password_digest
      t.boolean :active

      t.timestamps null: false
    end
  end
end
