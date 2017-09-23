Rails.application.routes.draw do
  root to: 'home#index'

  resources :books do
    resources :reviews, only: [:create, :destroy]
  end
  resources :orders
  resources :order_items, only: [:create, :destroy]

  get 'catalog', to: 'books#index'
  get 'cart',    to: 'cart#show'

  #post 'checkout_w/address', to: 'checkout_w/address#edit'

  resources :checkout

  namespace :checkout do
    get   'address',             to: 'address#edit'
    post  'address',             to: 'address#edit'
    patch 'address',             to: 'address#update'
    post  'same_address',        to: 'address#same_address'
    get   'delivery',            to: 'delivery#edit'
    patch 'delivery',            to: 'delivery#update'
    post  'apply_delivery_cost', to: 'delivery#apply_delivery_cost'
    get   'payment',             to: 'payment#edit'
    patch 'payment',             to: 'payment#update'
    get   'confirm',             to: 'confirm#show'
    post  'confirm',             to: 'confirm#update'
    get   'complete',            to: 'complete#show'
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
