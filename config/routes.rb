Rails.application.routes.draw do
  resources :episodes
  resources :seasons
  resources :movies
  resources :users
  resources :purchases
  resources :library do
    get :movies, on: :collection
    get :seasons_info, on: :collection
  end
end
