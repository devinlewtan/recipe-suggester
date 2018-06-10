Rails.application.routes.draw do

  get 'sessions/new'
  get 'users/new'


  root 'static_pages#home'
  get '/index', to: 'static_pages#home'
  get  '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/fridge', to: 'user_ingredients#index'
  #get '/fridge/new', to: 'user_ingredients#new'
  #get '/fridge/new', to: 'user_ingredients#create'
  
  resources :users
  resources :user_ingredients
end