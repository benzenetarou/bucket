Rails.application.routes.draw do


  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get 'contact', to: 'static_pages#contact'
  get 'signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/list', to: 'buckets#show'
  patch '/buckets/:id', to: 'buckets#accomplish'
  get '/users/:id/all', to: 'users#all', as: :all
  get '/users/:id/accomplished', to: 'users#accomplished', as: :accomplished
  get '/users/:id/unaccomplished', to: 'users#unaccomplished', as: :unaccomplished

  resources :users
  resources :buckets

end
