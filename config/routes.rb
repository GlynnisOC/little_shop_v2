Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'

  resources :merchants, only: [:index]

	namespace :dashboard do
		resources :items, only: [:index, :new, :create, :edit]
    resources :orders, only: :show
		post '/orders/:id/fulfill', to: 'orders#fulfill', as: 'order_fulfill'
  end

  namespace :dashboard do
    resources :orders, only: [:show]
  end 

  get '/dashboard', to: 'merchants#dashboard', as: 'dashboard'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'application#logout'

  resources :items, only: [:index, :show, :create, :edit]
  # patch 'dashboard/items/:id/edit', to: 'items#update'
  patch 'items/:id/edit', to: 'items#update'
  post '/items/:id/disable', to: "items#disable", as: 'disable_item'
  post '/items/:id/enable', to: "items#enable", as: 'enable_item'
  delete '/items/:id/delete', to: "items#delete", as: 'delete_item'

  get '/profile', to: 'users#profile'
  get '/profile/edit', to: 'users#edit'
  patch '/profile/edit', to: 'users#update' # refactor expect to patch to '/profile'
  get 'profile/orders', to: "orders#index"
  get 'profile/orders/:id', to: "orders#show", as: 'order_show'

  post '/orders/:id/ship', to: "orders#ship_packaged_order", as: 'ship_packaged_order'
  post '/orders/:id/cancel', to: "orders#cancel_pending_order", as: 'cancel_pending_order'

  resources :users, only: [:index, :new, :create, :show, :edit]

  namespace :admin do
    get  '/dashboard', to: "admins#dashboard"
		post '/users/:id', to: "users#upgrade", as: 'upgrade_user'
		post '/merchants/:id', to: "merchants#downgrade", as: 'downgrade_merchant'
		post '/merchants/:id/enable', to: "merchants#enable", as: 'enable_merchant'
		post '/merchants/:id/disable', to: "merchants#disable", as: 'disable_merchant'
		resources :users, only: [:index, :show]
		resources :merchants, only: [:show, :index]
  end

  get '/cart', to: 'cart#show'
  post '/cart', to: 'cart#create', as: 'add_to_cart'
  delete '/cart', to: 'cart#empty_cart', as: 'empty_cart'
  patch '/cart', to: 'cart#change_amount', as: 'change_amount'
	post '/cart/checkout', to: 'cart#check_out', as: 'check_out'
end
