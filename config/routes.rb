Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :users, only: [:show] do
    member do
      get 'my_movies', as: :my_movies
    end
  end
  resources :movies, only: [:index, :create, :show]
  resources :site_statistics, only: [:index]

  scope '(:locale)', :locale => /en|ru/ do
    root 'movies#index'
  end

  get '*path' => redirect('/')
end
