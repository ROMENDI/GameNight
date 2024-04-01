Rails.application.routes.draw do
  get 'home/index'
  get 'games/index'
  get 'games/show'
  get 'games/new'
  get 'games/edit'
  get 'games/create'
  get 'games/update'
  get 'games/destroy'
  get 'reservations/create'
  get 'reservations/update'
  get 'reservations/destroy'
  get 'users/show'
  get 'users/edit'
  get 'users/update'
  get 'events/index' 
  get 'events/show'
  get 'events/new'
  get 'events/edit'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
