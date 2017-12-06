Rails.application.routes.draw do
  root to: 'toppages#index'
  # sessioncontroller
  get 'login', to: 'sessions#new' 
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  

  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create, :edit, :update, :edit, :show]
  
  resources :tasks, only: [:create, :destroy, :new, :edit, :show, :update, :index]
end
