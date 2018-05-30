Rails.application.routes.draw do
  get 'welcome/index'

  get 'users/new'
  
  resources :ingredients


  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/login', to: 'static_pages#login'
  get  '/signup',  to: 'users#new'
end