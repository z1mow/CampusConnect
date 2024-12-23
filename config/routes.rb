Rails.application.routes.draw do
  root 'chatroom#index' # Chatroom ana sayfa

  resources :users, only: [:new, :create, :show]
  
  post 'message', to: 'messages#create'
  post 'login', to: 'sessions#create'
  get 'login', to: 'sessions#new'
  delete 'logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  
  # manifest.json için varsayılan bir yanıt
  get '/manifest.json', to: ->(_) { [204, {}, ['']] }
end
