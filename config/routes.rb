Rails.application.routes.draw do

  resources :actions, only: :index
  resources :users
  resources :roles, only: [:create, :index]
  resources :views, only: :index

end
