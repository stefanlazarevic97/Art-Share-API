Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

    resources :users, except: [:new, :edit] do 
        resources :artworks, only: :index
        resources :comments, only: :index
        get :likes, to: 'users#likes', as: 'likes'
    end
  
    resources :artworks, except: [:index, :new, :edit] do 
        resources :comments, only: :index
        post :like, to: 'artworks#like', as: 'like'
        get :likers, to: 'artworks#likers', as: 'likers'
    end

    resources :artwork_shares, only: [:create, :destroy]

    resources :comments, only: [:create, :destroy, :index] do
        post :like, to: 'comments#like', as: 'like'
        get :likers, to: 'comments#likers', as: 'likers'
    end
end
