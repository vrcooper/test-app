Rails.application.routes.draw do
  
  
  post '/checkouts', to: 'orders#checkout'
  

  get 'wikis/create'

  devise_for :users

  resources :checkouts, only: [:new, :create]

  resources :orders, only: [:new, :create]

  delete 'orders/downgrade'

  resources :wikis

  
  
      
      get "welcome/index"
  
    authenticated do
  
      root to: 'wikis#index', as: :authenticated_root
      
    end

    unauthenticated do

      root to: 'welcome#index'
  end
 
end
