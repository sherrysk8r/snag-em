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

  get 'find_a_workout', :to => 'posts#find_a_workout'
  get 'filter_by_workout', :to => 'posts#filter_by_workout'
  get 'filter_by_time', :to => 'posts#filter_by_time'

  root to: 'home#index', as: :home
end
