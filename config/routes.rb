Rails.application.routes.draw do
  root to: 'home#index'

  resources :books do
    resources :reviews, only: [:create, :destroy]
  end
  resources :orders
  resources :order_items, only: [:create, :destroy]

  get 'catalog', to: 'books#index'
  get 'cart', to: 'cart#show'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
