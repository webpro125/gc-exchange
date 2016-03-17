require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admins, path: '/admin', path_names: { sign_in: 'login', sign_out: 'logout'},
             controllers: { sessions: 'admin/sessions'},
             :skip => [:registrations]

  # devise_for :consultants, path: '/', path_names: { sign_in:      'login',
  #                                                   sign_out:     'logout' },
  #            :skip => [:registrations]
             # controllers:        { registrations: 'registrations' }

  devise_for :users, path: '/', path_names: { sign_in:  'login',
                                   sign_out: 'logout',
                                   sign_up: 'register' },
             controllers:        { registrations: 'registrations' }
  # Root Paths
  # authenticated :consultant do
  #   root 'profiles#consultant', as: :consultant_root
  # end
  authenticated :user do
    root 'users#index', as: :user_root
  end

  namespace :admin do
    get '/', :to => 'dashboard#index'
    resources :dashboard
    resources :consultants do
      resources :conversations, only: [:new, :create]
      member do
        put :approve
        put :reject
        get :contract
      end
    end
    resources :companies, path: 'contractors' do
      resources :users
    end
    resources :admins
    resources :projects, path: 'offers'

    resources :conversations, only: [:index, :show, :destroy] do
      member do
        post :reply
        put :approve_personal_contact
        post :restore
      end
      collection do
        delete :empty_trash
      end
    end
  end

  scope :admin do
    get :searches, path:'search', to: 'admin/searches#new', as: :admin_search
  end
  authenticated :admin do
    root :path => 'admin/dashboard', :to => 'admin/dashboard#index', as: :admin_root
  end

  authenticate :user, ->(u) { u.gces? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  root 'pages#home'
  get :user_welcome, to: 'pages#user_welcome'
  get :company_welcome, to: 'pages#company_welcome'
  get :consultant_benefits, to: 'pages#consultant_benefits'
  get :contractor_benefits, to: 'pages#contractor_benefits'
  get :how_we_do_it, to: 'pages#how_we_do_it'
  get :about_us, to: 'pages#about_us'
  get :contact_us, to: 'pages#contact_us'
  get :terms_of_service, to: 'pages#terms_of_service'
  get :privacy_policy, to: 'pages#privacy_policy'
  get :profile_completed, to: 'pages#profile_completed'
  get :health_check, to: 'pages#health_check'
  get 'download_resume/:id', to: 'downloads#download_resume', as: :download_resume

  # Resources
  resource :change_password, only: [:edit, :update]

  get :search, to: 'searches#new'
  get 'search/skills', to: 'searches#skills'

  get :consultant_profile, to: 'profiles#consultant', as: :consultant_root
  get :create_consultant, to: 'users#create_consultant'

  scope :consultant_profile do
    resources :consultant_projects, path: 'offers', only: [:index, :show] do
      member do
        post :agree_to_terms
        post :reject_terms
        post :not_interested
      end
    end

    get 'account_setting', to: 'settings#edit'
    patch 'account_setting/update_sms_notification', to: 'settings#update_sms_notification'

    resource :profile, only: [:edit, :update, :show]

    resources :project_histories, path: 'projects', except: [:show]
  end

  get :contractor_profile, to: 'contractors#profile', as: :contractor_root

  resources :create_profile, only: [:show, :update]
  resources :sales_leads, only: [:new, :create]
  resources :projects, path: 'offers', only: [:index, :new, :create] do
    member do
      post :not_pursuing
    end
  end

  resources :companies, path: 'contractors' do
    resources :users
  end
  resources :update_contracts, only: [:new, :update] do
    member do
      get :skip
    end
  end
  resources :consultants, only: [:index, :show] do
    resources :conversations, only: [:new, :create]
    resources :upload_images, only: [:new, :create]
    resources :upload_resumes, only: [:new, :create]
    resources :projects, path: 'offers', shallow: true, except: [:index, :destroy, :new, :create]
    member do
      put :approve
      put :reject
      get :contract
    end
  end
  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
      put :approve_personal_contact
      post :restore
    end
    collection do
      delete :empty_trash
    end
  end
  resources :reports, only: [] do
    collection do
      get :consultant
      get :search
      get :visits
    end
  end
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
