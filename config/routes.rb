Rails.application.routes.draw do
  # Devise routes for authentication
  devise_for :users
  
  # Root route
  root "home#index"

  resources :games, only: [:index, :show]

  resources :events
  get 'my_events', to: 'events#my_events'

    
  resources :reservations, except: [:index]
  
  resources :users, only: [:show]

  
end
