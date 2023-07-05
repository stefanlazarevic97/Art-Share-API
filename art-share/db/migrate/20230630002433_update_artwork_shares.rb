class UpdateArtworkShares < ActiveRecord::Migration[7.0]
  def change
    add_column :artwork_shares, :favorited, :boolean
  end
end
