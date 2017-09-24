Rails.application.routes.draw do
  root to: 'home#index'
  get  'catalog',            to: 'books#index'
  get  'settings/addresses', to: 'addresses#index'
  post 'settings/addresses', to: 'addresses#create'
  get  'settings/privacy',   to: 'users#index'
  put  'settings/privacy',   to: 'users#update'

  resources :books, only: %i[index show] do
    resources :reviews, only: :create
  end
  resource  :cart, only: %i[show update]
  resources :checkout
  resources :credit_card
  resources :orders, only: %i[index show]
  resources :order_items, only: %i[create update destroy]
  #resources :users, only: %i[update destroy]

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
