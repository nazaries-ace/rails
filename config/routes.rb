Rails.application.routes.draw do
  
  # Default
  root 'welcome#index'
  get 'about', to: 'pages#about'
  get 'home', to: 'pages#home'

  #articles
  resources :articles
  # Users
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  ##sessions
  get 'login', to: 'sessions#new'  
  post 'login', to: 'sessions#create'  
  delete 'logout', to: 'sessions#destroy'

  #categories
  resources :categories, except: [:destroy]
end
