Rails.application.routes.draw do
  root to: "pages#home"
  get 'user/:id', to: 'users#show', as: 'user'
  devise_for :users do
    resources :products
  end
end
