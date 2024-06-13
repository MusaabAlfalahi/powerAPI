Rails.application.routes.draw do
  resources :user, only: [:create]
  resource :session, only: [:create, :destroy]
  resource :locations, only: [:index, :show, :create, :update, :destroy]
  resource :warehouse, only: [:index, :show, :create, :update, :destroy]
  resource :station, only: [:index, :show, :create, :update, :destroy]
end
