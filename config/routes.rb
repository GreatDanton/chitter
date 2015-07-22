Rails.application.routes.draw do


  get 'sessions/new'

  resources :discussions

  root 'discussions#frontpage'
  get 'signup' => "users#new"

  resources :users
  get 'login' => "sessions#new"
  post 'login' => "sessions#create"
  delete 'logout' => "sessions#destroy"

  resources :account_activations, only: [:edit]
end
