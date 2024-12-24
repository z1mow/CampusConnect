Rails.application.routes.draw do

  root 'chatroom#index'
  resources :users, only: [:new, :create]
  
  resources :community_groups do
    resources :group_members, only: [:create, :destroy]
    resources :messages, only: [:create] # Messages için nested routes
    get 'chatroom', to: 'chatroom#index'
  end

  post 'login', to: 'sessions#create'
  get 'login', to: 'sessions#new'
  post 'message', to: 'messages#create'
  get 'logout', to: 'sessions#destroy'

  mount ActionCable.server, at: '/cable'
end