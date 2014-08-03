PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  resources :posts, except: [:destroy] do
    resources :comments, only: [:create] do
      member do
        post 'vote'
      end
    end

    member do
      post 'vote'
    end
    
    collection do
      get 'search'
    end
  end

  resources :categories, only: [:create, :new, :show]

  resources :users, only: [:new, :create, :edit, :update, :show]
  
  get "/register", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/profile", to: "users#edit"


  # resources :dogs
  # get '/dogs', to: 'dogs#index'           --> index
  # get '/dogs/:id', to: 'dogs#show'        --> show
  # get '/dogs/new', to: 'dogs#new'         --> new
  # post '/dogs', to: 'dogs#create'         --> create
  # get '/dogs/:id/edit', to: 'dogs#edit'   --> edit
  # patch '/dogs/:id', to: 'dogs#update'    --> update (patch/put)
  # delete '/dogs/:id', to: 'dogs#destroy'  --> destroy

end
