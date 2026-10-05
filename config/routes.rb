Rails.application.routes.draw do
  root "static_pages#top"

  resources :users, only: %i[new create]
  resources :lists, only: %i[index new create destroy] do
    resources :items, only: %i[create update destroy]
  end

  resources :template_lists, only: %i[index new create destroy] do
    resources :template_items, only: %i[create update destroy]
  end

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
