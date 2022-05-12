Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'users/registrations' }

  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:new, :create]
    end
  end

  namespace :api do
    get 'authentication' , to: 'authentication#new'
    post 'authentication/create' , to: 'authentication#create'
    get 'users/:id/posts', to: 'apiposts#index'
    get 'users/:user_id/posts/:id/comments', to: 'apicomments#index', as: 'comments'
    get 'users/:user_id/posts/:id/comments/new', to: 'apicomments#new'
    post 'users/:user_id/posts/:id/comments/create', to: 'apicomments#create', as: 'create_comment'
  end

end
