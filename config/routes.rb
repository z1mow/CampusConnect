Rails.application.routes.draw do
  root 'chatroom#index'
  resources :users, only: [:new, :create]
  post 'message', to: 'messages#create'
  post 'login', to: 'sessions#create'
  get 'login', to: 'sessions#new'
  delete 'logout', to: 'sessions#destroy'
end
