Rails.application.routes.draw do

  root 'application#welcome'
  resources :users
  resources :tournaments
  resources :matches
  resources :opponents, only: [:show, :edit, :update, :delete]

  get '/login' => "sessions#new"
  post '/login' => "sessions#create"
  get '/logout' => 'sessions#destroy'
end
