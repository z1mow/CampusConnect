Rails.application.routes.draw do

  root 'chatroom#index'
  resources :users, only: [:new, :create]
  post 'login', to: 'sessions#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  post 'message', to: 'messages#create'
  get 'logout', to: 'sessions#destroy'

  mount ActionCable.server, at: '/cable'
end
