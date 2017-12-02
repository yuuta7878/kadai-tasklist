Rails.application.routes.draw do
  root to: 'tasks#index'
  root to: 'toppages#index'
  resources :tasks
end
