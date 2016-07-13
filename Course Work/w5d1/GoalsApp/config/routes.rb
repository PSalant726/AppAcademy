Rails.application.routes.draw do
  resources :users, only: [:new, :create, :destroy]
  resources :goals
  resource :session, only: [:new, :create, :destroy]
  root "goals#index"
end
