Rails.application.routes.draw do
  root "static_pages#top"

  resources :users, only: %i[new create]
  resources :lists, only: %i[index new create destroy] do
    resources :items, only: %i[update destroy]
  end

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
end
