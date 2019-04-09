Rails.application.routes.draw do

  root 'application#welcome'

  resources :users do
    resources :tournaments, only: [:index, :new]
  end

  resources :tournaments
  resources :matches
  resources :opponents, only: [:show, :edit, :update, :delete]
  resources :style_tags, except: [:show]

  get '/login' => "sessions#new"
  post '/login' => "sessions#create"
  get '/logout' => 'sessions#destroy'
end
