Meeting::Application.routes.draw do
  resources :rooms do
    member do     
      post 'new'
      put 'update'
      post 'create'
      get 'edit'
      get 'show'
      get 'destroy'
    end
    collection do
      get 'index'
    end
  end
  

  # get "rooms/destroy"
  # resources :rooms


  resources :positions


  resources :user_types


  resources :d_departments


  resources :b_departments

  get "users/change_password"
  get "users/index"
  get "users/destroy"
  resources :users

  # resources :admin do
  #   member do
  #     get 'login'
  #     get 'loginout'
  #     post 'modifypwd'
  #   end
  # end
  # match "admin/login"=>"/admin#login", :via => :get
  # match "admin/loginout"=>"/admin#loginout", :via => :get
  # match "admin/loginout"=>"/admin#modifypwd", :via => :post
  # get "admin/login"
  # get "admin/login_test"
  get "schedules/index"
  get "schedules/add_schedule"
  get "schedules/destroy_schedule"
  get "backstage/index"
  



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
    root :to => 'versions#index'
    post "admin/login"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
    match ':controller(/:action(/:id))(.:format)', :via => [:get, :post]
end
