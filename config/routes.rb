Rails.application.routes.draw do

  get 'sessions/new'
  get 'users/new'
  get 'recipes/new'


  root 'static_pages#home'
  get '/index', to: 'static_pages#home'
  get  '/signup',  to: 'users#new'
  post  '/signup',  to: 'users#signup'
  get    '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  get    '/profile',   to: 'sessions#show'
  post   '/login',   to: 'sessions#login'
  delete '/logout',  to: 'sessions#destroy'
  get '/fridge', to: 'user_ingredients#index'
  get '/recipes', to: 'recipes#index'


  resources :users
  resources :user_ingredients
  resources :recipes

end
