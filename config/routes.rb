Rails.application.routes.draw do
  resources :users
  resources :words
  root 'users#index'
  get '/auth/:provider/callback', to: 'users#callback' 
end
