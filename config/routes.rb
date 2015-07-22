Rails.application.routes.draw do
  resources :tags
  root to: 'entries#index'
  devise_for :users
  resources :entries do
    resources :comments
  end
end
