PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  resources :posts, except: [:destroy] do
    resources :comments, only: [:create]

    collection do
      get 'search'
    end
  end

  resources :categories, only: [:create, :new, :show]
end
