Rails.application.routes.draw do
  namespace :v1 do
    resources :users, only: [:create, :index] do
      resource :baskets, only: [:show, :update, :destroy]
      resources :orders, only: [:index, :show, :create]
    end
    resources :sessions, only: :create
    resources :products, only: [:index]
  end
end
