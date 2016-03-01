Rails.application.routes.draw do
  devise_for :users

  resources :users do
    member do
      get 'my_movies', as: :my_movies
    end
  end
  resources :movies

  scope '(:locale)', :locale => /en|ru/ do
    root 'movies#index'
  end
end
