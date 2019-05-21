Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'

  resources :items, only: [:index]
  get '/merchants', to: 'merchants#index'
  get '/profile', to: 'users#profile'

  resources :users, only: [:index, :new, :create, :show]
end
