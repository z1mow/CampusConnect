Rails.application.routes.draw do
  root 'chatrooms#index'

  resources :chatrooms, only: [:index, :show, :new, :create] do
    resources :messages, only: [:create]
  end

  get 'login', to: 'sessions#new'
end
