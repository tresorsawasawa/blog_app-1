Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  devise_for :users, :controllers => { registrations: 'users/registrations' }

  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:new, :create]
    end
  end

  namespace :api do
    post 'authentication/create' , to: 'authentication#create'
    get 'users/:id/posts', to: 'apiposts#index'
    get 'posts/:id/comments', to: 'apicomments#index', as: 'comments'
    post 'posts/:id/comments/create', to: 'apicomments#create', as: 'create_comment'
  end

end
