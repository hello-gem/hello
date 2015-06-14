Hello::Engine.routes.draw do
  

  get  'locale' => 'locale#index'
  post 'locale' => 'locale#update'

  resources :access_tokens, only: [:index, :destroy]

  root "welcome#index"
  get  "homepage" => "welcome#homepage"

  match  "sign_out" => "sign_out#sign_out", via: [:get, :post, :head, :put, :delete]

  # account
    # user
    get   'user' => "current_user#edit",  as: 'current_user'
    patch 'user' => "current_user#update"

    get   'password' => "password#edit"
    patch 'password' => "password#update"
    # (:/id) so it won't understand format: '1' in some Rails versions, causing an UnknownFormat error

  # sudo mode
    get   'sudo_mode'        => 'sudo_mode#form'
    patch 'sudo_mode'        => 'sudo_mode#authenticate'
    get   'sudo_mode/expire' => 'sudo_mode#expire'

  # deactivation
    get  'deactivation' => 'deactivation#proposal'
    post 'deactivation' => 'deactivation#deactivate'
    get  'deactivated'  => 'deactivation#deactivated'

  
  namespace "admin" do
    get '' => 'admin#index'
    # impersonation
      get  'impersonate' => 'impersonation#destroy'
      post 'impersonate' => 'impersonation#create'
  end

  resources :emails, only: [:index, :create, :destroy] do
    member do
      post "deliver"
      get "confirm/:token" => "confirm_emails#confirm", as: 'confirm'
    end
    collection do
      get "expired_token" => "confirm_emails#expired_token"
    end
  end

  # classic registration
    # sign up
    get  "sign_up"         => "email_sign_up#index"
    post "sign_up"         => "email_sign_up#create"
    get  "sign_up/widget"  => "email_sign_up#widget"

    # sign in
    get  "sign_in"         => "email_sign_in#index"
    post "sign_in"         => "email_sign_in#authenticate"
    get  "authenticated"   => "email_sign_in#authenticated"

    # forgot
    get  "password/forgot"          => "email_forgot_password#index"
    post "password/forgot"          => "email_forgot_password#remember"
    get  "password/remembered"      => "email_forgot_password#remembered"

    # reset
    get  "password/reset/done"      => "reset_password#done"
    get  "password/reset/:token"    => "reset_password#reset_token", as: 'reset_token'
    get  "password/reset"           => "reset_password#index"
    post "password/reset"           => "reset_password#save"





end
