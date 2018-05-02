Rails.application.routes.draw do
  get 'users/new'

  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/login', to: 'static_pages#login'
  get  '/signup',  to: 'users#new'
end