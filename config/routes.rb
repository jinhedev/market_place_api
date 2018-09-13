require 'api_constraints'

Rails.application.routes.draw do
  # api definition
  namespace :api, defaults: { format: :json }, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      # list of resources here
      devise_for :users
      resources :users, only: [:show, :create, :update, :destroy] do
        resources :products, only: [:create, :update, :destroy]
      end
      resources :sessions, only: [:create, :destroy]
      resources :products, only: [:show, :index]
    end
  end

  # namespace :api, defaults: { format: :json } do
  #   namespace :v1 do
  #     # list of resources here
  #     devise_for :users
  #     resources :users, only: [:show, :create, :update, :destroy] do
  #       resources :products, only: [:create, :update, :destroy]
  #     end
  #     resources :sessions, only: [:create, :destroy]
  #     resources :products, only: [:show, :index]
  #   end
  # end
end
