# == Schema Information
#
# Table name: artworks
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  favorited  :boolean
#
class Artwork < ApplicationRecord
    validates :title, presence: true
    validates :image_url, presence: true, uniqueness: true
    validates :artist_id, uniqueness: { scope: :title }

    belongs_to :artist,
        class_name: :User

    has_many :artwork_shares,
        foreign_key: :artwork_id,
        dependent: :destroy,   
        inverse_of: :artwork

    has_many :comments,
        foreign_key: :artwork_commented_id,
        dependent: :destroy,
        inverse_of: :artwork_commented

    has_many :likes,
        as: :likeable,
        dependent: :destroy
    
    has_many :likers,
        through: :likes,
        source: :liker

    has_many :shared_viewers,
        through: :artwork_shares,
        source: :viewer

    def self.artworks_for_user_id(user_id)
        Artwork
            .left_outer_joins(:artwork_shares)
            .where("artist_id = (?) OR viewer_id = (?)", user_id, user_id)
            .order("artworks.id")
    end
end
