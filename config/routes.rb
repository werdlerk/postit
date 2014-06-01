PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  resources :posts, except: [:destroy]
  resources :categories, only: [:create, :new, :show]
end
