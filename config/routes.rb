Rails.application.routes.draw do
require 'sidekiq/web'
mount Sidekiq::Web => '/sidekiq'
  resources :episodes
  resources :seasons
  resources :movies
  resources :users do
    get :purchases, on: :member
    post '/purchase', to: 'purchases#purchase', on: :member
  end
  resources :purchases
  resources :library do
    get :movies, on: :collection
    get :seasons_info, on: :collection
  end
end