Rails.application.routes.draw do
  resources :users
  resources :movies
  root 'movies#index'
end
