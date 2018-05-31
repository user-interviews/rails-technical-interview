Rails.application.routes.draw do
  root 'static_pages#root'

  get '/sign-in', to: 'user_sessions#new', as: :sign_in
  post '/sign-in', to: 'user_sessions#create'
  delete '/sign-out', to: 'user_sessions#delete', as: :sign_out

  get '/sign-up', to: 'users#new', as: :sign_up
  post '/sign-up', to: 'users#create'

  get '/projects/:id/share', to: 'projects#share', as: :share_project
  get '/projects/:id/perform_share', to: 'projects#perform_share', as: :perform_share_project
  get '/projects/:id/revoke_share', to: 'projects#revoke_share', as: :revoke_share_project

  resources :projects, only: [:new, :create, :show]
  resources :users, only: [:show]
end
