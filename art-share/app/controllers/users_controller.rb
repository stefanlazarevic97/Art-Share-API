class UsersController < ApplicationController
    def index
        if params[:username].nil?
            users = User.all
        else
            temp_str = "%#{params[:username]}%"
            users = User.where("username ILIKE ?", temp_str) # case insensitive
        end

        render json: users
    end

    def create
        user = User.new(user_params)
        
        if user.save
            render json: user, status: :created
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end
    end

    def show 
        user = User.find(params[:id])
        render json: user
    end

    def update
        user = User.find_by(id: params[:id])
        
        if user.update(user_params)
            render json: user, status: :accepted
        else
            render json: user.errors.full_messages, status: 422
        end
    end

    def destroy
        user = User.find_by(id: params[:id])
        user.destroy
        redirect_to users_url
    end

    def likes
        user = User.find_by(id: params[:user_id])
        render json: user.likes
    end

    private
    
    def user_params
        params.require(:user).permit(:username)
    end
end
