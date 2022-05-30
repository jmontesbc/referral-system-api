Rails.application.routes.draw do

  resources :actions, only: :index
  resources :views, only: :index
  resources :users
  resources :positions

end
