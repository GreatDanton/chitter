Rails.application.routes.draw do


  resources :comments
  resources :discussions do
    resources :comments
  end
  root 'discussions#frontpage'
  
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  get 'signup' => "users#new"

  resources :users
  get 'login' => "sessions#new"
  post 'login' => "sessions#create"
  delete 'logout' => "sessions#destroy"

  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
end
