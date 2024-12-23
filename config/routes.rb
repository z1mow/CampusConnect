Rails.application.routes.draw do
  root 'chatrooms#index'

  resources :chatrooms, only: [:index, :show, :new, :create] do
    resources :messages, only: [:create]
  end

  post 'message', to: 'messages#create'

  resources :users, only: [:new, :create]
  post 'login', to: 'sessions#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  mount ActionCable.server, at: '/cable'
end
