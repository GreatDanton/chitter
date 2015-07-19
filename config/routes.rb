Rails.application.routes.draw do
  get 'users/new'

  resources :discussions

  root 'discussions#frontpage'
  get 'signup' => "users#new"

  resources :users

end
