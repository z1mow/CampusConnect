Rails.application.routes.draw do
  root 'pages#home'
  #root "home#index"
  
  # Chatroom routes
  get 'chatroom', to: 'chatroom#index', as: :chatroom
  
  # Messages routes
  resources :messages, only: [:index, :create]
  
  resources :users, only: [:new, :create, :show, :edit, :update]
  get 'account', to: 'users#show', as: :account

  get 'search', to: 'users#search', as: 'user_search'

  get 'profile/edit', to: 'users#edit', as: :edit_profile
  patch 'profile', to: 'users#update', as: :update_profile
  get 'profile', to: 'users#show', as: 'profile'
  
  resources :community_groups do
    member do
      post 'join'
      delete 'leave'
    end
    resources :group_members, only: [:create, :destroy]
    resources :messages, only: [:create]
    get 'chatroom', to: 'chatroom#index'
  end

  get 'signup', to: 'users#new', as: :signup
  post 'login', to: 'sessions#create'
  get 'login', to: 'sessions#new'
  post 'message', to: 'messages#create'
  get 'logout', to: 'sessions#destroy'

  mount ActionCable.server, at: '/cable'
end