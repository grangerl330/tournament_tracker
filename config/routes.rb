Rails.application.routes.draw do

  root 'application#welcome'
  resources :users, only: [:new, :create, :show]
  resources :tournaments
  resources :matches
  resources :opponents

  get '/login' => "sessions#new"
  post '/login' => "sessions#create"
  get '/logout' => 'sessions#destroy'
end
