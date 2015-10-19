Rails.application.routes.draw do
  resources :users
  resources :posts
  resources :tagalongs
  resources :reviews

  post 'add_tagalong/:id' => 'posts#addtagalong', as: :addtagalong
  post 'add_review/:id' => 'tagalongs#addreview', as: :addreview
  
  get 'user/pending_tagalongs' => 'users#pending_tagalongs', as: :pending
  resources :sessions
  get 'user/edit' => 'users#edit', :as => :edit_current_user
  get 'signup' => 'users#new', :as => :signup
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout

  get 'filter_workouts', :to => 'posts#filter_workouts'

  root to: 'home#index', as: :home
end
