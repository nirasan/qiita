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
    resources :comments
  end

  resources :tags

end
