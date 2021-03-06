Kauppalista::Application.routes.draw do

  get "api_user_requests/index"

  get "api_user_requests/accept"

  get "api_user_requests/deny"

  get "api_user/create"

  get "home/index"

  resources :users
  match "signup" => "users#new"
  match "login" => "sessions#login"
  match "logout" => "sessions#logout"
  post "sessions/login_attempt"

  get 'lists/clean'
  resources :lists

  resources :items

  #get 'list/form'

  get 'api_users/create'
  get 'api_users/index'
  match 'api_users/:api_user_id/request_access' => 'api_users#request_user_access', :via => :get

  match 'requests' => 'api_user_requests#index'
  match 'requests/:id/accept' => 'api_user_requests#accept'
  match 'requests/:id/deny' => 'api_user_requests#deny'

  root :to => 'home#index'
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
