Rails.application.routes.draw do
  root 'pages#home'
  
  # Chatroom routes
  get 'chatroom', to: 'chatroom#index', as: :chatroom
  
  # Messages routes
  resources :messages, only: [:index, :create]
  
  # User routes with all functionality
  resources :users do
    collection do
      get 'search'
    end
    member do
      post 'send_friend_request'
      post 'accept_friend_request'
      post 'reject_friend_request'
      delete 'remove_friend'
      get 'chat'
    end
  end

  # Profile routes
  get 'account', to: 'users#show', as: :account
  get 'profile/edit', to: 'users#edit', as: :edit_profile
  patch 'profile', to: 'users#update', as: :update_profile
  get 'profile', to: 'users#show', as: 'profile'
  
  # Community groups routes
  resources :community_groups do
    member do
      post 'join'
      delete 'leave'
    end
    resources :group_members, only: [:create, :destroy]
    resources :messages, only: [:create]
    get 'chatroom', to: 'chatroom#index'
  end

  # Authentication routes
  get 'signup', to: 'users#new', as: :signup
  post 'login', to: 'sessions#create'
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'

  # Friend routes
  resources :friends, only: [:index] do
    collection do
      get 'pending_requests'
      get 'my_friends'
    end
  end

  # Direct Messages routes
  resources :direct_messages, only: [:create] do
    collection do
      get 'conversation/:user_id', to: 'direct_messages#conversation', as: 'conversation'
    end
  end

  # Private Messages routes
  resources :private_messages, only: [:create] do
    collection do
      get 'conversation/:user_id', to: 'private_messages#conversation', as: 'conversation'
    end
  end

  mount ActionCable.server, at: '/cable'
end