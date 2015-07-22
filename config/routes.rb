Rails.application.routes.draw do

  root to: 'entries#index'

  devise_for :users
  resources :users, only: [:show]

  resources :entries do
    resources :comments
  end

  resources :tags

end
