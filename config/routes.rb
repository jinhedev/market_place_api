Rails.application.routes.draw do
  # api definition
  namespace :api, defaults: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do
    scope module: :v1 do
      # list of resources here

    end
  end
end
