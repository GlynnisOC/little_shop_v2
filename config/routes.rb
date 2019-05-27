Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'

  resources :merchants, only: [:index]

	namespace :dashboard do
		resources :items, only: [:index, :new, :create, :edit]
	end

  get '/dashboard', to: 'merchants#dashboard', as: 'dashboard'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  get '/logout', to: 'application#logout'

  resources :items, only: [:index, :show, :create, :edit]
  # patch 'dashboard/items/:id/edit', to: 'items#update'
  patch 'items/:id/edit', to: 'items#update'

  get '/profile', to: 'users#profile'
  get '/profile/edit', to: 'users#edit'
  patch '/profile/edit', to: 'users#update'
  get 'profile/orders', to: "orders#index"
  get 'profile/orders/:id', to: "orders#show", as: 'order_show'

  resources :users, only: [:index, :new, :create, :show, :edit]

  namespace :admin do
    get  '/dashboard', to: "admins#dashboard"
		post '/users/:id', to: "users#upgrade", as: 'upgrade_user' 
		resources :users, only: [:index, :show] 
		resources :merchants, only: [:show]
  end

  get '/cart', to: 'cart#show'
  post '/cart', to: 'cart#create', as: 'add_to_cart'
  delete '/cart', to: 'cart#empty_cart', as: 'empty_cart'
  patch '/cart', to: 'cart#change_amount', as: 'change_amount'
end
