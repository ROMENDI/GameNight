Rails.application.routes.draw do
  # Devise routes for authentication
  devise_for :users
  
  # Root route
  root "home#index"

  resources :games

  resources :events

  resources :events do
    resources :reservations, only: [:create, :update, :destroy]
  end

  resources :users, only: [:show, :edit, :update]

  get 'my_events', to: 'events#my_events'
end
