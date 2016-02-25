Rails.application.routes.draw do
  get '/sign_up' => 'users#new', as: :sign_up
  get '/sign_in' => 'user_sessions#new', as: :sign_in
  delete '/sign_out' => 'user_sessions#destroy', as: :sign_out

  resources :users
  resources :user_sessions, only: [:new, :create]
  resources :movies

  root 'movies#index'
end
