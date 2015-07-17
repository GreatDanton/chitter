Rails.application.routes.draw do
  resources :discussions

  root 'pages#index'

  resources :pages

end
