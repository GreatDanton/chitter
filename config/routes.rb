Rails.application.routes.draw do


  resources :categories do
    resources :discussions
  end

  resources :comments do
    member do
      put "upvote" => "comments#upvote"
      put "downvote" => "comments#downvote"
      put "unvote" => "comments#unvote"
    end
  end

  resources :discussions do
    member do
      put "upvote" => "discussions#upvoteDiscussion"
      put "downvote" => "discussions#downvoteDiscussion"
      put "unvote" => "discussions#unvoteDiscussion"
    end
  end

  get 'faq' => 'categories#FAQ'
  
  get 'leaderboards' => 'users#leaderboards'

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
