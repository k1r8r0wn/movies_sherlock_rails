Rails.application.routes.draw do
  get '/sign_up' => 'users#new', as: :sign_up
  get '/sign_in' => 'user_sessions#new', as: :sign_in
  delete '/sign_out' => 'user_sessions#destroy', as: :sign_out

  resources :users
  resources :movies
  resources :user_sessions, only: [:new, :create]
  resources :password_resets, only: [:new, :create, :edit]

  root 'movies#index'
end
