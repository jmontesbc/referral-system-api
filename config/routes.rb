Rails.application.routes.draw do

  resources :actions, only: :index
  resources :views, only: :index

  resources :users, only: [:index, :create, :show, :update]  do
    member do
      put 'delete'
    end
  end

end
