class ArtworksController < ApplicationController
    def index
        # user = User.find(params[:user_id])
        # artworks = user.artworks + user.shared_artworks

        artworks = Artwork.artworks_for_user_id(params[:user_id])
        render json: artworks.uniq
    end

    def create
        artwork = Artwork.new(artwork_params)
        
        if artwork.save
            render json: artwork, status: :created
        else
            render json: artwork.errors.full_messages, status: :unprocessable_entity
        end
    end

    def show 
        artwork = Artwork.find(params[:id])
        render json: artwork
    end

    def update
        artwork = Artwork.find_by(id: params[:id])
        
        if artwork.update(artwork_params)
            render json: artwork, status: :accepted
        else
            render json: artwork.errors.full_messages, status: 422
        end
    end

    def destroy
        artwork = Artwork.find_by(id: params[:id])
        artwork.destroy
        render json: artwork
    end

    def like
        like = Like.new(user_id: params[:user_id], likeable_type: "Artwork", likeable_id: params[:artwork_id])

        if like.save
            render json: like, status: :created
        else
            render json: like.errors.full_messages, status: :unprocessable_entity
        end
    end

    def likers
        artwork = Artwork.find(params[:artwork_id])
        render json: artwork.likers
    end

    private
    
    def artwork_params
        params.require(:artwork).permit(:title, :image_url, :artist_id, :user_id)
    end
end
