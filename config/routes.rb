require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users
  # api definition
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      # list of resources here
      resources :users, :only => [:show, :create]
    end
  end
end
