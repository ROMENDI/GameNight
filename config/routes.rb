Rails.application.routes.draw do
  # Devise routes for authentication
  devise_for :users

  # Root route
  root "home#index"

  resources :games, only: [:index, :show]

  resources :events
  get 'my_events', to: 'events#my_events'
  ## Remove extra lines in your route file.
  ## It is okay to add spacing for readability. Just keep it consistent.

  resources :reservations, except: [:index,:show]

  resources :users, only: [:show]


end
