Rails.application.routes.draw do

  root 'welcome#index'

  resources :users
  get '/profile', to: 'users#show'

  get '/events/invited', to: 'events#invited'
  resources :events

  resources :comments

  put '/attendees/:id', to: 'attendees#update', as: :status_attendee

  #resources :attendees #, only: [:show, :update]

  resources :sessions, only: [:new, :create, :destroy]

  get '/login', to: 'sessions#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
