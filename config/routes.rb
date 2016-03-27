Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: 'callbacks' }

  resources :users, only: [:show, :search]

  resources :movies, only: [:index, :create, :show, :search] do
    member do
      post 'vote_for'
      post 'vote_against'
      delete 'unvote'
      post 'add_video'
    end
    collection do
      get 'search'
    end
  end

  resources :dashboard, only: [:index]

  scope '(:locale)', :locale => /en|ru/ do
    root 'movies#index'
  end

  get '/:id' => 'users#show', as: :users
  get '/:id/my_movies' => 'users#my_movies', as: :my_movies

  get '*path' => redirect('/')
end
