Rails.application.routes.draw do
  get 'bids/new'

  get 'bids/create'

  root 'static_pages#home'
  #get '/about', to: 'static_pages#about'
  #get '/contact', to: 'static_pages#contact'

  #devise_for :users, :controllers => { omniauth_callbacks: "users/omniauth_callbacks", registrations: 'registrations' }
  
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}, skip: :registrations
  devise_scope :user do 
    resource :registration,
      only: [:new, :create, :edit, :update],
      path: 'user',
      path_names: { new: 'sign_up'},
      controller: 'registrations',
      as: :user_registration do 
        get :cancel
      end
  end


  resources :users, only: [:show] do
		member do
			get :history
    end
    resources :reviews, only: [:create, :destroy, :index]
    resources :notifications, only: [:index]
  end

  resources :conversations, only: [:index, :show]
  resources :messages, only: [:create]

  resources :auctions do
    member do
      get :history, :comments
    end
    resources :bids, only: [:new, :create]
    resources :comments, only: [:create, :destroy]
  end

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
