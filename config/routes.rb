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
             controllers:        { registrations: 'registrations', sessions: 'sessions' }
  # Root Paths
  # authenticated :consultant do
  #   root 'profiles#consultant', as: :consultant_root
  # end
  authenticated :user do
    root 'users#index', as: :user_root
  end

  namespace :api do
    resources :geo_users, only: :index
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
    resources :companies, path: 'companies' do
      member do
        get :invite_account_manager
        put :send_invite
        delete :destroy_account_manager
        delete :destroy_requested_company
      end
      get :registration_requests, :on => :collection
      get :autocomplete_user_email, :on => :collection
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

    resources :articles, path: 'blog' do
      resources :comments, only: [:index, :create, :update]
      member do
        put :close_article
        put :open_article
      end
    end

    resources :comments do
      get :load_comment
    end

    resources :reports, only: [] do
      collection do
        get :consultant
        get :search
        get :public
        get :general_user
        get :company
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
  get 'article/download_attachment/:id', to: 'downloads#download_article_attachment', as: :download_article_attachment
  get 'comment/download_attachment/:id', to: 'downloads#download_comment_attachment', as: :download_comment_attachment
  get 'download_gsc/:id', to: 'downloads#gsc', as: :download_gsc
  get 'download_contract_rider/:id', to: 'downloads#contract_rider', as: :download_contract_rider
  get 'download_sow/:id', to: 'downloads#sow', as: :download_sow

  get 'business_unit_roles/accept_role/:accept_token', to: 'business_unit_roles#accept_role', as: :accept_business_role
  put 'business_unit_roles/put_accept_role/:accept_token', to: 'business_unit_roles#put_accept_role', as: :put_accept_business_role
  get 'account_managers/accept/:access_token', to: 'account_managers#accept', as: :accept_am
  get 'business_unit_names/accept/:access_token', to: 'business_unit_names#accept_by_token', as: :accept_bum
  # Resources
  resource :change_password, only: [:edit, :update]

  get :search, to: 'searches#new'
  get 'search/skills', to: 'searches#skills'

  get :consultant_profile, to: 'profiles#consultant', as: :consultant_root
  get :create_consultant, to: 'users#create_consultant'

  get :contractor_profile, to: 'contractors#profile', as: :contractor_root

  resources :create_profile, only: [:show, :update]
  resources :sales_leads, only: [:new, :create]
  resources :projects, path: 'drafts', only: [:index] do
    member do
      post :not_pursuing
    end
  end

  resources :companies, path: 'contractors' do
    # resources :users
  end
  resources :update_contracts, only: [:new, :update] do
    member do
      get :skip
    end
  end
  resources :consultants, only: [:show] do
    resources :conversations, only: [:new, :create]
    resources :upload_images, only: [:new, :create]
    resources :upload_resumes, only: [:new, :create]
    resources :projects, path: 'drafts', except: [:index, :destroy]
    member do
      put :approve
      put :reject
      get :contract
    end
  end

  namespace :consultant_profile do
    # resources :consultant_projects, path: 'offers', only: [:index, :show] do
    #   member do
    #     post :agree_to_terms
    #     post :reject_terms
    #     post :not_interested
    #   end
    # end

    resources :projects, path: 'drafts' do
      resources :project_agreements, path: 'reviews'
    end
  end

  get 'account_setting', to: 'settings#edit'
  patch 'account_setting/update_sms_notification', to: 'settings#update_sms_notification'
  resources :project_histories, path: 'projects', except: [:show]
  resource :profile, only: [:edit, :update, :show]
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

  resources :articles, path: 'blog' do
    resources :comments
  end

  resource :articles do
    post :upload_attachment
    delete :destroy_attachment
  end

  resources :comments do
    get :load_comment
  end

  resources :account_managers, only: [:new, :create], :path_names => { :new => "invite", :create => 'create' } do
    put :update_assign_business_role # not used yet
    get :autocomplete_user_email, :on => :collection
  end

  resources :business_unit_names, only: [:new, :create] do

  end

  resources :business_unit_roles, only: [:new, :create] do
    collection do
      get :autocomplete_user_email
    end
  end

  resource :companies, only:[] do
    get :registration
    put :do_registration
  end

  resource :users, only: [] do
    get :registration_process
    get :workflow
  end
  # Non resource
  resources :project_agreements, only: [:index] do
    resources :ra_reviews, path: 'review_drafts_for_ra', only: [:new, :create]
  end
end
