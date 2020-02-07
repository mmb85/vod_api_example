Rails.application.routes.draw do
  resources :episodes
  resources :seasons
  resources :movies
  resources :users do
    get :purchases, on: :member
  end
  resources :purchases
  resources :library do
    get :movies, on: :collection
    get :seasons_info, on: :collection
  end
end
