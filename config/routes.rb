Rails.application.routes.draw do
  root to: "pages#home"

  resources :users, only: ['new', 'create', 'update', 'show', 'delete'] do
    resources :products
  end
end
