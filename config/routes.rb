Rails.application.routes.draw do
  resources :user, only: [:create]
  resource :session, only: [:create, :destroy]
end
