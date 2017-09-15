Rails.application.routes.draw do
  root to: 'home#index'

  resources :authors
  resources :books do
    resources :reviews
  end
  resources :categories
  #resources :reviews

  get 'catalog', to: 'books#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
