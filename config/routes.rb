Rails.application.routes.draw do
  resources :discussions

  root 'discussions#index'
end
