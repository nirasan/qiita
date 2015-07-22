Rails.application.routes.draw do

  root to: 'entries#index'

  devise_for :users
  resources :users, only: [:show] do
    member do
      post :follow
      post :unfollow
    end
  end

  resources :entries do
    member do
      post :stock
      post :unstock
    end
    resources :comments
  end

  resources :tags do
    member do
      post :follow
      post :unfollow
    end
  end

end
