Rails.application.routes.draw do
  root to: "pages#home"
  get 'user/:id', to: 'users#show', as: 'user'
  delete 'products/:id', to: 'products#destroy', as: 'delete'
  devise_for :users
  resources :products
  get 'products/consoles/:type', to: 'products#index', as: 'console-page'
end
