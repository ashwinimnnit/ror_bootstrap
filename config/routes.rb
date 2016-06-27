Rails.application.routes.draw do
  root "profiles#index"
  resources :profiles
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    registrations: "registrations",
    passwords: "password"
  }
  # adding custom urls in devise controller
  devise_scope :user do
    post "/user/check_availability/email",
         to:  "registrations#check_email_availability"
    get "user/signup", to:  "registrations#new"
    get "user/password/", to: "password#new", as: "forgot_password"
  end
  get "/stream", to: "profiles#live_streaming"
  get "admins/users", to: "admins#list"
  get "/admins/add_members", to: redirect("/admins/new")
  match "/admins/role_userole" => "admins#users", via: [:get, :post]
  match "/role_userole" => "admins#users", via: [:get, :post]
  resources :users
  resources :posts
  resources :admins
  post "check/to_delete_id/" => "admins#remove"
  post "admins/add_members" => "admins#add_members"
  get "/about_us/" => "aboutus#about_us"
  get "/contact_us" => "aboutus#contact_us"
  post "/profiles/user/role/:id" => "profiles#get_role"
  match "/admin_assign_roles" => "admins#admin_assign_roles", via: [:get, :post]
  match "/update" => "admins#bulk_user_update", via: [:post, :get]
  # You can have the root of your site routed with "root"
  # atch "/profiles/update/profile/pic" =>
  # profiles#update_profile_pic", via: [:get, :post], defaults: { format: "js" }
  patch "/update_profile_image", to: "profiles#update_profile_image"
  get "/", to: "profiles#index"
  get "/admins/add_members", to: "admins#add_members"
  post "/profiles/getuser/image", to: "profiles#fb_image"
  post "/notifications", to: "notifications#send_notifications"
  get "/message/:id", to: "profiles#message"
  #get "/chatroom", to: "notifications#logged_in_user"
  post "/post_chat", to: "profiles#send_chat"
  get "/getnotifications", to: "notifications#display_notification"
  # dynamic routing for api
  get "/apis", to: "apis/welcome#index"
  post ":controller(/:action(/*params))", controller: /apis\/[^\/]+/
  get ":controller(/:action(/*params))", controller: /apis\/[^\/]+/
  put ":controller(/:action(/*params))", controller: /apis\/[^\/]+/
  patch ":controller(/:action(/*params))", controller: /apis\/[^\/]+/
  delete ":controller(/:action(/*params))", controller: /apis\/[^\/]+/
end
