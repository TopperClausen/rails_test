Rails.application.routes.draw do
  resources :users, only: [:create, :index]
  resources :sessions, only: :create
end
