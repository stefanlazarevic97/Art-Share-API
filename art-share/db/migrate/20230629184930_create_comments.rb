class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :body, null: false
      t.references :commenter, null: false, foreign_key: { to_table: :users }
      t.references :artwork_commented, null: false, foreign_key: { to_table: :artworks }
      
      t.timestamps
    end
  end
end
