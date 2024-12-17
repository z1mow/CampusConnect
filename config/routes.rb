Rails.application.routes.draw do
  root 'chatrooms#index'

  resources :chatrooms, only: [:index, :show, :new, :create] do
    resources :messages, only: [:create]
  root 'chatroom#index'
  post 'message', to: 'messages#create'
  post 'login', to: 'sessions#create'
  get 'login', to: 'sessions#new'
  delete 'logout', to: 'sessions#destroy'
end
