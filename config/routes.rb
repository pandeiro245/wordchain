Rails.application.routes.draw do
  resources :users
  resources :words
  get '/auth/:provider/callback', to: 'users#callback' 
end
