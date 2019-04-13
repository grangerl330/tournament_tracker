Rails.application.routes.draw do

  root 'sessions#new'

  resources :users do
    resources :tournaments, only: [:index, :new]
    resources :opponents, only: [:index]
  end

  resources :tournaments
  resources :matches
  resources :opponents
  resources :style_tags, except: [:show]

  get '/login' => "sessions#new"
  post '/login' => "sessions#create"
  get '/logout' => 'sessions#destroy'
  get '/auth/facebook/callback' => 'sessions#create_facebook_omniauth'
end
