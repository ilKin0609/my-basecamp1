Rails.application.routes.draw do
  devise_for :users
  
  resources :projects do
    resources :memberships, only: [:create, :destroy, :update]
    resources :topics, only: [:create, :destroy] do
      resources :messages, only: [:create, :destroy]
    end
    resources :tasks, only: [:create, :destroy, :update]
    resources :attachments, only: [:create, :destroy]
  end
  
  root to: "home#index"
end