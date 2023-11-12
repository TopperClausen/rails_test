Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :v1 do
    resources :users, only: [:create] do
      resource :baskets, only: [:show, :update, :destroy]
      resources :orders, only: [:index, :show, :create]
    end
    resources :sessions, only: :create
    resources :products, only: [:index]
  end
end
