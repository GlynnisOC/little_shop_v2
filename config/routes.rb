Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'

  resources :merchants, only: [:index]

	namespace :dashboard do
		resources :items, only: [:index]
	end

  get '/dashboard', to: 'merchants#dashboard', as: 'dashboard'
  # get '/merchants', to: 'merchants#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  get '/logout', to: 'application#logout'

  resources :items, only: [:index, :show]

  get '/profile', to: 'users#profile'

  resources :users, only: [:index, :new, :create, :show, :edit]

  namespace :admin do
    get  '/dashboard',    to: "admins#dashboard"
  end

  # resources :cart, only: [:create]
  get '/cart', to: 'cart#index'
  post '/cart', to: 'cart#create', as: 'add_to_cart'
end
