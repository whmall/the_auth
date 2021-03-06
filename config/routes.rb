Rails.application.routes.draw do

  scope module: :the_auth, controller: :join do
    get 'join', action: 'new'
    post 'join', action: 'create'
  end

  scope module: :the_auth, controller: :login do
    get 'login', action: 'new'
    post 'login', action: 'create'
    get 'logout', action: 'destroy'
  end

  scope module: :the_auth, controller: :password, path: :password do
    get 'forget', action: 'new', as: 'password_forget'
    post 'forget', action: 'create'
    get 'reset/:token', action: 'edit', as: 'password_reset'
    post 'reset/:token', action: 'update'
  end

  scope module: :the_auth, controller: :confirm, path: :confirm do
    get 'email/:token', action: 'edit', as: 'confirm'
    post 'email/:token', action: 'update'
  end

  namespace :admin do
    resources :users do
      patch :toggle, on: :member
    end
    resources :oauth_users
  end

  namespace :api do
    resource :me
    controller :login do
      post 'login', action: 'create'
    end
    resources :oauth_users, only: [:create]
  end

end
