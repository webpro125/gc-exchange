require 'sidekiq/web'

Rails.application.routes.draw do

  devise_for :consultants, path: '/', path_names: { sign_in: 'login',
                                                    sign_out: 'logout',
                                                    registration: 'register' },
                                      controllers: { registrations: 'registrations' }

  devise_for :users, path: '/users/', path_names: { sign_in: 'login',
                                                    sign_out: 'logout' }
  # Root Paths
  authenticated :consultant do
    root 'pages#consultant', as: :consultant_root
  end
  authenticated :user do
    root 'pages#user', as: :user_root
  end
  authenticate :user, ->(u) { u.gces? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  root 'pages#home'

  # Resources
  resource :address, except: [:destroy, :show]
  resource :military, except: [:new, :edit, :show, :index]
  resource :search, only: [:new, :create]
  resources :phones
  resources :project_histories, path: 'projects'
  resources :sales_leads, only: [:new, :create]
  resources :companies

  # Non resource

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
