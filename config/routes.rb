Rails.application.routes.draw do
  root 'chatroom#index'
  resources :users, only: [:new, :create, :show, :edit, :update]

  get 'profile/edit', to: 'users#edit', as: :edit_profile
  patch 'profile', to: 'users#update', as: :update_profile
  get 'profile', to: 'users#show', as: 'profile'
  
  resources :community_groups do
    resources :group_members, only: [:create, :destroy]
    resources :messages, only: [:create] # Messages için nested routes
    get 'chatroom', to: 'chatroom#index'
  end

  get 'signup', to: 'users#new', as: :signup
  post 'login', to: 'sessions#create'
  get 'login', to: 'sessions#new'
  post 'message', to: 'messages#create'
  get 'logout', to: 'sessions#destroy'

  #post 'message', to: 'messages#create'
 
  # Manifest.json için varsayılan bir yanıt
  #get '/manifest.json', to: ->(_) { [204, {}, ['']] }

  mount ActionCable.server, at: '/cable'
end