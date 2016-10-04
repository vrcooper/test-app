Rails.application.routes.draw do
  
  get 'wikis/create'

  devise_for :users

  resources :checkouts, only: [:new, :create]

  delete 'charges/downgrade'

  resources :wikis

  
  
      
      get "welcome/index"
  
    authenticated do
  
      root to: 'wikis#index', as: :authenticated_root
      post '/checkouts', to: 'orders#checkout'
    end

    unauthenticated do

      root to: 'welcome#index'
  end
 
end
