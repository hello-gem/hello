Hello::Engine.routes.draw do
  



  # namespace :hello do
  # end

  get  'locale' => 'locale#index'
  post 'locale' => 'locale#update'

  resources :active_sessions, only: [:index, :destroy]

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
    get  "forgot_password" => "registration#forgot"
    post "forgot_password" => "registration#ask"
    get  "after_forgot"    => "registration#after_forgot"

    # reset
    get  "reset/token/:token" => "registration#reset_token", as: 'reset_token'
    get  "reset_password"     => "registration#reset"
    post "reset_password"     => "registration#save"
    get  "after_reset"        => "registration#after_reset"

    # confirm email
    get  "confirm_email/send"         => "registration#confirm_email_send"
    get  "confirm_email/token/:token" => "registration#confirm_email_token", as: 'confirm_email_token'
    get  "confirm_email/expired"      => "registration#confirm_email_expired"
    get  "after_confirm_email"        => "registration#after_confirm_email"

  end

  get  'deactivation'       => 'deactivation#proposal'
  post 'deactivation'       => 'deactivation#deactivate'
  get  'after_deactivation' => 'deactivation#after_deactivate'






end
