# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true

    has_many :artworks,
        foreign_key: :artist_id,
        dependent: :destroy,
        inverse_of: :artist

    has_many :artworks_viewed,
        foreign_key: :viewer_id,
        class_name: :ArtworkShare,
        dependent: :destroy,
        inverse_of: :viewer

    has_many :comments,
        foreign_key: :commenter_id,
        dependent: :destroy,
        inverse_of: :commenter

    has_many :shared_artworks,
        through: :artworks_viewed,
        source: :artwork

    has_many :likes,
        foreign_key: :user_id,
        dependent: :destroy,
        inverse_of: :liker
end
