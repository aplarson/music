Rails.application.routes.draw do
  root to: 'bands#index'

  resources :users, only: [:create, :new, :show]
  resource :session, only: [:create, :new, :destroy]
  resources :bands do
    resources :albums, only: [:new]
  end
  resources :albums, except: [:new] do
    resources :tracks, only: [:new]
  end
  resources :tracks, except: [:new] do
    resources :notes, only: [:create, :destroy]
  end
end
