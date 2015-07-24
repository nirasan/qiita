Rails.application.routes.draw do

  root to: 'entries#index'

  get :my, to: 'my#index'

  devise_for :users
  resources :users, only: [:show] do
    member do
      post :follow
      post :unfollow
      get :entries
      get :comments
      get :stocks
      get :followers
      get :followees
      get :tags
    end
  end

  resources :entries do
    member do
      post :stock
      post :unstock
    end
    collection do
      post :preview
    end
    resources :comments, only: [:new, :edit, :create, :update, :destroy]
  end

  resources :tags, only: [:show] do
    member do
      post :follow
      post :unfollow
    end
  end

  resources :infos, only: [:index]

end
