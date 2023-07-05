class UpdateArtworks2 < ActiveRecord::Migration[7.0]
  def change
    add_column :artworks, :favorited, :boolean
  end
end