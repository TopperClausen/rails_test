Rails.application.routes.draw do
  resources :users, only: [:create, :index] do
    resource :baskets, only: [:show, :update, :destroy]
  end
  resources :sessions, only: :create
  resources :products, only: [:index]
end
