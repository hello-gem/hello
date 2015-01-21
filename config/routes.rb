Hello::Engine.routes.draw do
  





  # namespace :hello do
  # end

  get  'locale' => 'locale#index'
  post 'locale' => 'locale#update'

  resources :access_tokens, only: [:index, :destroy]

  root "welcome#index"
  get  "homepage" => "welcome#homepage"

  match  "sign_out" => "sign_out#sign_out", via: [:get, :post, :head, :put, :delete]

  # account
    # user
    get   'user' => "user#edit"
    patch 'user' => "user#update"

  # sudo mode
    get   'sudo_mode'        => 'sudo_mode#form'
    patch 'sudo_mode'        => 'sudo_mode#authenticate'
    get   'sudo_mode/expire' => 'sudo_mode#expire'

  # deactivation
    get  'deactivation'       => 'deactivation#proposal'
    post 'deactivation'       => 'deactivation#deactivate'
    get  'after_deactivation' => 'deactivation#after_deactivate'

  
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

  end


  # classic registration
    # sign up
    get  "sign_up"         => "classic_registration/sign_up#index"
    post "sign_up"         => "classic_registration/sign_up#create"



  # classic/registration
  
    # sign in
    get  "sign_in"         => "classic/registration#sign_in"
    post "sign_in"         => "classic/registration#authenticate"
    get  "after_sign_in"   => "classic/registration#after_sign_in"

    # forgot
    get  "forgot_password" => "classic/registration#forgot"
    post "forgot_password" => "classic/registration#ask"
    get  "after_forgot"    => "classic/registration#after_forgot"

    # reset
    get  "reset/token/:token" => "classic/registration#reset_token", as: 'reset_token'
    get  "reset_password"     => "classic/registration#reset"
    post "reset_password"     => "classic/registration#save"
    get  "after_reset"        => "classic/registration#after_reset"

    # confirm email
    get  "confirm_email/send"         => "classic/registration#confirm_email_send"
    get  "confirm_email/token/:token" => "classic/registration#confirm_email_token", as: 'confirm_email_token'
    get  "confirm_email/expired"      => "classic/registration#confirm_email_expired"
    get  "after_confirm_email"        => "classic/registration#after_confirm_email"








end
