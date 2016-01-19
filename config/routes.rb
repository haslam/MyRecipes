Rails.application.routes.draw do
  
  root 'pages#home'
  get '/home', to: 'pages#home'
  ## All these can be achieved with the resource command
  #
  #get '/recipes', to: 'recipes#index'
  #get '/recipes/new', to: 'recipes#new', as: 'new_recipe'
  
  #post '/recipes', to: 'recipes#create'
  #get '/recipes/:id/edit', to: 'recipes#edit', as: 'edit_recipe'
  #patch 'recipes/:id', to: 'recipes#update'
  #get 'recipes/:id', to: 'recipes#show', as: 'recipe'
  #delete 'recipes/:id', to: 'recipes#destroy'
  resources :recipes do
      member do
        post 'like'
      end
  end
  
  resources :chefs, except: [:new]  # except is used to exclude a route from being created
  
  get '/register', to: 'chefs#new'  # create a register route using the chefs#new
  
  get '/login', to: 'logins#new'  #login page link
  
  post '/login', to: 'logins#create'  # loging in that creates login session
  
  get '/logout', to: 'logins#destroy' #logout destroys session
  
  resources :styles, only: [:new, :create, :show]
  resources :ingredients, only: [:new, :create, :show]
end
