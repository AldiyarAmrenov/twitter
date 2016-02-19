Rails.application.routes.draw do

  root 'pages#home'

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :sessions,      only: [:new, :create, :destroy]
  resources :microposts,    only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  get 'about', to: "pages#about"

  get 'contact', to:'pages#contact'

  get 'help', to: 'pages#help'
  
  get 'signup', to: 'users#new'

  match 'signin', to: 'sessions#new', via: :get
  
  match 'signout', to: 'sessions#destroy', via: :delete 
end
