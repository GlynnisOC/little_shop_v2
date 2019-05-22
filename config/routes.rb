Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'welcome#index'

  resources :items, only: [:index]
  resources :merchants, only: [:index]
  # resources :merchants, only: [:index], as: 'dashboard' do
  #   get '/dashboard', to: "merchants#dashboard"
  # end


  get '/dashboard', to: 'merchants#dashboard', as: 'dashboard'
  get '/logout', to: 'welcome#index'

end
