Rails.application.routes.draw do


  resources :discussions

  root 'discussions#frontpage'
  get 'signup' => "users#new"

  resources :users

end
