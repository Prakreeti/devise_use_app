Rails.application.routes.draw do
  
  

  resources :subscribers, only: :create
  
  post '/rate' => 'rater#create', :as => 'rate'

  resources :friend_requests, only: [:create, :index, :destroy, :update]
  resources :friends, only: [:index, :destroy]

  resources :posts do
    member do
      get :liked_by
    end
    resources :comments 
    
  end

  get 'users/find_friends', to: 'users#find_friends'

  get '/post/myblogs', to: 'posts#myblogs'

  resources :comments, only: :show do
    member do
      get :liked_by
    end
  end

  
  devise_for :users, controllers: { registrations: 'registrations',
                     omniauth_callbacks: "users/omniauth_callbacks" }
  authenticated :user do
    root 'users#dashboard', as: :authenticated_root
  end

  # for the home page
  root 'users#public'

  resources :users do
    member do
      get :follows, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]

  resources :likes, only: [:create, :destroy]
  resources :comment_likes, only: [:create, :destroy]

  resources :tags, only: [:index, :show]
  get 'tagged', to: 'posts#tagged'

  get 'home', to: 'users#dashboard'

  get '*a', :to => 'errors#routing'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
