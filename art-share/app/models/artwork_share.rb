# == Schema Information
#
# Table name: artwork_shares
#
#  id         :bigint           not null, primary key
#  artwork_id :bigint           not null
#  viewer_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  favorited  :boolean
#
class ArtworkShare < ApplicationRecord
    validates :artwork_id, :viewer_id, presence: false
    validates :artwork_id, uniqueness: { scope: :viewer_id }
    
    belongs_to :artwork

    belongs_to :viewer,
        class_name: :User
end
