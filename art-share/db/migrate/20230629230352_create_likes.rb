class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :likeable, null: false, polymorphic: true
      
      t.timestamps
    end
  end
end
