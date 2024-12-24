Rails.application.routes.draw do
  # Ana sayfa
  root 'chatroom#index'

  # Kullanıcı işlemleri
  resources :users, only: [:new, :create, :show, :edit, :update]

  # Profil işlemleri
  get 'profile/edit', to: 'users#edit', as: :edit_profile
  patch 'profile', to: 'users#update', as: :update_profile
  get 'profile', to: 'users#show', as: 'profile'

  # Oturum işlemleri
  get 'signup', to: 'users#new', as: :signup
  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: :logout

  # Mesaj işlemleri
  post 'message', to: 'messages#create'
 
  # Manifest.json için varsayılan bir yanıt
  get '/manifest.json', to: ->(_) { [204, {}, ['']] }
end