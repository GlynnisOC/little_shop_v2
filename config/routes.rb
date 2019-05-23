Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'

  resources :merchants, only: [:index]
  get '/dashboard', to: 'merchants#dashboard', as: 'dashboard'
  # get '/merchants', to: 'merchants#index'

  get '/logout', to: 'application#logout'

  resources :items, only: [:index, :show]

  get '/profile', to: 'users#profile'

  resources :users, only: [:index, :new, :create, :show, :edit]

  namespace :admin do
    get  '/dashboard',    to: "admin#dashboard"
  end

  # resources :carts, only: [:create]
  get '/carts', to: 'carts#index'
  post '/carts', to: 'carts#create', as: 'add_to_cart'
end
