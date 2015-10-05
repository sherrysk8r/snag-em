class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :tagalong_id
      t.integer :owner_stars
      t.integer :accuracy_of_event_stars
      t.text :review
      
      t.timestamps null: false
    end
  end
end
