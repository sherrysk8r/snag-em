Rails.application.routes.draw do
  resources :users
  resources :posts
  resources :tagalongs

  post 'add_tagalong/:id' => 'posts#addtagalong', as: :addtagalong
  
  resources :sessions
  get 'user/edit' => 'users#edit', :as => :edit_current_user
  get 'signup' => 'users#new', :as => :signup
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout

  root to: 'home#index', as: :home
end
