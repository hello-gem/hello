Hello::Engine.routes.draw do
  



  resources :sessions, only: [:index, :show]

  root "welcome#index"

  match  "sign_out" => "sign_out#sign_out", via: [:get, :post, :head, :put, :delete]

  # editing profile
    # user
    get   'user' => "user_profile#edit"
    patch 'user' => "user_profile#update"

  # sudo mode
    get   'sudo_mode'        => 'sudo_mode#form'
    patch 'sudo_mode'        => 'sudo_mode#authenticate'
    get   'sudo_mode/expire' => 'sudo_mode#expire'

  
  namespace "admin" do
    get '' => 'admin#index'
    # impersonation
      get  'impersonate' => 'impersonation#destroy'
      post 'impersonate' => 'impersonation#create'
  end

  namespace "classic" do
    
    resources :credentials, only: [:update] do
      member do
        get :email, :username, :password
      end
    end

    # registration
    # sign up
    get  "sign_up"         => "registration#sign_up"
    post "sign_up"         => "registration#create"
    get  "after_sign_up"   => "registration#after_sign_up"

    # sign in
    get  "sign_in"         => "registration#sign_in"
    post "sign_in"         => "registration#authenticate"
    get  "after_sign_in"   => "registration#after_sign_in"

    # forgot
    get  "forgot"         => "registration#forgot"
    post "forgot"         => "registration#ask"
    get  "after_forgot"   => "registration#after_forgot"

    # reset
    get  "reset/token/:token" => "registration#reset_token", as: 'reset_token'
    get  "reset"              => "registration#reset"
    post "reset"              => "registration#save"
    get  "after_reset"        => "registration#after_reset"

    # confirm email
    get  "confirm_email/send"         => "registration#confirm_email_send"
    get  "confirm_email/token/:token" => "registration#confirm_email_token", as: 'confirm_email_token'
    get  "confirm_email/expired"      => "registration#confirm_email_expired"
    get  "after_confirm_email"        => "registration#after_confirm_email"

  end






end
