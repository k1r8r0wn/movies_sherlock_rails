Rails.application.routes.draw do
  resources :users
  resources :user_sessions, only: [:new, :create]
  resources :movies

  root 'movies#index'
end
