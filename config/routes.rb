Rails.application.routes.draw do

 resources :profiles
 devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' } 
  #adding custom urls in deviose controller
 #devise_scope :user do
      #match 'admin/addmembers', to: 'registrations#admin_add_members' , :via => [:get, :post]
  #end
  get 'admins/users', to: 'admins#list'
  match '/admins/role_userole' => 'admins#get_users', via: [:get,:post]
 match '/role_userole' => 'admins#get_users', via: [:get,:post]
  resources :users
  resources :posts
  resources :admins
  post 'check/to_delete_id/' => 'admins#remove'
  post 'admins/add_members' => 'admins#add_members'
  get '/about_us' => 'aboutus#about_us' 
  get '/contact_us' => 'aboutus#contact_us' 
  post '/profiles/user/role/:id' => 'profiles#get_role'
  match '/admin_assign_roles' => 'admins#admin_assign_roles' ,via: [:get,:post]
  match '/update' => 'admins#bulk_user_update' ,via:[:post,:get]
  # You can have the root of your site routed with "root"
   root 'posts#index'
   # root 'devise/sessions#new '
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
