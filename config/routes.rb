Rails.application.routes.draw do
  root 'pages#home'
  
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

  # User routes with friends
  resources :users do
    member do
      post 'send_friend_request'
      post 'accept_friend_request'
      post 'reject_friend_request'
      delete 'remove_friend'
    end
  end

  # Friend routes
  resources :friends, only: [:index] do
    collection do
      get 'pending_requests'
      get 'my_friends'
    end
  end

  mount ActionCable.server, at: '/cable'
end