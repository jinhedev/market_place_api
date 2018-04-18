require 'api_constraints'

Rails.application.routes.draw do
  # api definition
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      # list of resources here

    end
  end
end
