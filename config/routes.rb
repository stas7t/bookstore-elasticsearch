Rails.application.routes.draw do
  resources :categories
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  resources :authors
  resources :books
  resources :reviews

  get 'catalog', to: 'catalog#index'
  get 'xorders', to: 'xorders#index'
  get 'xsettings', to: 'xsettings#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
