Rails.application.routes.draw do

  root 'welcome#index'

  resources :users

  get '/events/invited', to: 'events#invited'
  resources :events

  resources :comments

  resources :sessions, only: [:new, :create, :destroy]

  get '/login', to: 'sessions#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
