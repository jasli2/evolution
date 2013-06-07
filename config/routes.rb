Evolution::Application.routes.draw do

  mount Resque::Server, :at => "/resque"

  resources :courses, :only => [:index] do
    collection {post :import}
    collection {get :export}
  end

  resources :users, :shallow => true do
    get 'dashboard', :on => :member
    get 'mgr_assessments', :on => :member
    get 'assessment', :on => :member
    post 'assessment', :action => :update_assessment, :as => :update_assessment, :on => :member
    collection {post :import}
    collection {get :export}
    resources :courses
  end
  resources :user_relations, only: [:create, :destroy]


  resources :competencies do
    collection {post :import}
    collection {get :export}
  end

  resources :positions do
    collection {post :import}
    collection {get :export}
  end

  resources :examinations do
    resources :questions 
  end

  match  '/about'         => 'site#about', :via => :get
  match  '/help'          => 'site#help', :via => :get
  match  '/knowledge'     => 'site#knowledge', :via => :get
  match  '/details'       => 'site#details', :via => :get
  match  '/datamining'    => 'site#datamining', :via => :get

  match  '/login'   => 'sessions#new', :via => :get
  match  '/logout'  => 'sessions#destroy', :via => :get
  match  '/signup'  => 'users#new', :via => :get

  resources :sessions, only: [:create]

  namespace :admin do
    match '/dashboard'          => 'admin#dashboard', :via => :get
    match '/manage_users'       => 'admin#user', :via => :get
    match '/manage_competency'  => 'admin#competency', :via => :get
    match '/manage_course'      => 'admin#course', :via => :get
    match '/manage_position'    => 'admin#position', :via => :get
  end

  root :to => 'sessions#new'

  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'errors#error_404'
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
