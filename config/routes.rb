Rails.application.routes.draw do
  post '/sign_up', to: 'user#create'

  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'

  get '/locations', to: 'locations#index'
  get '/locations/:id', to: 'locations#show'
  post '/locations', to: 'locations#create'
  put '/locations/:id', to: 'locations#update'
  delete '/locations/:id', to: 'locations#destroy'

  get '/warehouses', to: 'warehouses#index'
  get '/warehouses/:id', to: 'warehouses#show'
  post '/warehouses', to: 'warehouses#create'
  put '/warehouses/:id', to: 'warehouses#update'
  delete '/warehouses/:id', to: 'warehouses#destroy'

  get '/stations', to: 'stations#index'
  get '/stations/:id', to: 'stations#show'
  post '/stations', to: 'stations#create'
  put '/stations/:id', to: 'stations#update'
  put '/stations/:id/location', to: 'stations#assign_to_location'
  put '/stations/:id/warehouse', to: 'stations#assign_to_warehouse'
  delete '/stations/:id', to: 'stations#destroy'

  get '/power_banks', to: 'power_banks#index'
  get '/power_banks/available', to: 'power_banks#index_available'
  get '/power_banks/:id', to: 'power_banks#show'
  post '/power_banks', to: 'power_banks#create'
  put '/power_banks/:id', to: 'power_banks#update'
  put '/power_banks/:id/take', to: 'power_banks#take'
  put '/power_banks/:id/return', to: 'power_banks#return'
  put '/power_banks/:id/assign_to_station', to: 'power_banks#assign_to_station'
  put '/power_banks/:id/assign_to_warehouse', to: 'power_banks#assign_to_warehouse'
  put '/power_banks/:id/assign_to_user', to: 'power_banks#assign_to_user'
  delete '/power_banks/:id', to: 'power_banks#destroy'
end
