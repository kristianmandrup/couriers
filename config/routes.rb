Tiramizoo::Application.routes.draw do

  # Info pages
  match 'info/couriers'   => 'info#couriers',   :as => :couriers_info
  match 'info/businesses' => 'info#businesses', :as => :businesses_info
  match 'info/private'    => 'info#private',    :as => :private_info

  # Search couriers
  match 'search/couriers'    => 'search#couriers',  :as => :search_couriers

  # list of potential types of User registrations
  resources :registrations, :only => [:index]

  # Track booking using existing booking number
  resources :tracking,  :only => [:show]

  # Booking procedure
  resources :bookings,  :only => [:new] # updates booking session?
  resources :schedule,  :only => [:new, :create]
  resources :payment,   :only => [:new, :create]  

  devise_for :users, :admins

  devise_for :individual_couriers, :class_name => 'Courier::Individual'
  as :individual_courier do
    match "/individual_couriers/sign_up" => "devise/registrations#new", :as => :courier_signup
    match "/individual_couriers/sign_in" => "main#index", :as => :courier_signin
  end

  devise_for :courier_companies, :class_name => 'Courier::Company'
  as :courier_company do
    match "/courier_companies/sign_up" => "devise/registrations#new", :as => :courier_company_signup
    match "/courier_companies/sign_in" => "main#index", :as => :courier_company_signin    
  end

  devise_for :privates_customers, :class_name => 'Customer::Private'
  as :private_customer do
    match "/private_customers/sign_up" => "devise/registrations#new", :as => :private_customer_signup
    match "/private_customers/sign_in" => "main#index", :as => :private_customer_signin        
  end

  devise_for :professional_customers, :class_name => 'Customer::Professional'
  as :professional_customer do
    match "/professional_customers/sign_up" => "devise/registrations#new", :as => :professional_customer_signup
    match "/professional_customers/sign_in" => "main#index", :as => :professional_customer_signin            
  end

  # namespace :admin do
  #   # Directs /admin/products/* to Admin::ProductsController
  #   # (app/controllers/admin/products_controller.rb)
  #   resources :products
  # end

  root :to => "main#index"

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id(.:format)))'
end
