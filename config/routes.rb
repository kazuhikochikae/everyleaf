Rails.application.routes.draw do
  get 'sessions/new'
  get 'tasks/index'
  resources :tasks
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'tasks#index'

  namespace :admin do
    resources :users do
    member do
      patch 'add_admin_role'
      patch 'remove_admin_role'
    end
    end
  end


end
