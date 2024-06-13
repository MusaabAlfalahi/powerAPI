Rails.application.routes.draw do
  resources :user, only: [:create]
  resource :session, only: [:create, :destroy]
  resource :locations, only: [:index, :show, :create, :update, :destroy]
end
