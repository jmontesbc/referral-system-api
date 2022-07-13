Rails.application.routes.draw do

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :actions, only: :index
  resources :users
  resources :roles, only: :create
  resources :views, only: :index

end
