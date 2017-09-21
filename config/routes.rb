Rails.application.routes.draw do
  root to: 'home#index'

  resources :authors
  resources :books do
    resources :reviews
    resources :order_items
  end
  resources :categories
  resources :orders do
    resources :order_items
  end

  #resources :reviews

  get 'catalog', to: 'books#index'
  get 'cart', to: 'cart#show'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
