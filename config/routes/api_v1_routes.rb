# encoding: utf-8
# frozen_string_literal: true

v1_api_routes = lambda do
  resource :sessions, only: %i[create destroy]

  resources :models, param: :slug, only: %i[index show] do
    collection do
      get :latest
      get :updated
      get :filters
    end
    get 'gallery', on: :member
  end

  resources :components, only: [] do
    get :categories, on: :collection
  end

  resources :images, only: %i[index] do
    get :random, on: :collection
  end

  resources :users, only: [] do
    collection do
      post :signup
      post :confirm
      get :current
      put 'current' => 'users#update'
      patch 'current' => 'users#update'
    end
  end

  resource :password, only: [:update] do
    collection do
      post 'request' => 'passwords#request_email'
      patch 'update/:reset_password_token' => 'passwords#update_with_token'
      put 'update/:reset_password_token' => 'passwords#update_with_token'
    end
  end

  resources :vehicles, except: [:show] do
    collection do
      get :count
      get ':username' => 'vehicles#public', as: :public
      get ':username/count' => 'vehicles#public_count', as: :public_count
    end
  end

  namespace :rsi do
    resources :citizens, only: [:show], param: :handle
    resources :orgs, only: %i[index show], param: :sid do
      member do
        get :ships
      end
    end
  end
end

scope :v1, as: :v1 do
  scope module: :v1, &v1_api_routes

  root to: "v1/base#root"
end
