Hello::Engine.routes.draw do
  



  root "root#index"


  


  #
  # EMAIL
  #

  get  "sign_up"         => "email_sign_up#index"
  post "sign_up"         => "email_sign_up#create"
  get  "sign_up/widget"  => "email_sign_up#widget"

  get  "sign_in"         => "email_sign_in#index"
  post "sign_in"         => "email_sign_in#authenticate"
  get  "authenticated"   => "email_sign_in#authenticated"

  get  "password/forgot"          => "email_forgot_password#index"
  post "password/forgot"          => "email_forgot_password#remember"
  get  "password/remembered"      => "email_forgot_password#remembered"

  resources :emails, only: [:index, :create, :destroy] do
    member do
      post "deliver"
      get "confirm/:token" => "confirm_emails#confirm", as: 'confirm'
    end
    collection do
      get "expired_token" => "confirm_emails#expired_token"
    end
  end



  #
  # ACCOUNT MANAGEMENT
  #

  get   'user' => "current_user#edit",  as: 'current_user'
  patch 'user' => "current_user#update"

  get   'sudo_mode'        => 'sudo_mode#form'
  patch 'sudo_mode'        => 'sudo_mode#authenticate'
  get   'sudo_mode/expire' => 'sudo_mode#expire'

  get  'deactivation' => 'deactivation#proposal'
  post 'deactivation' => 'deactivation#deactivate'
  get  'deactivated'  => 'deactivation#deactivated'


  #
  # PASSWORD MANAGEMENT
  #

  get   'password' => "password#edit"
  patch 'password' => "password#update"

  get  "password/reset/done"      => "reset_password#done"
  get  "password/reset/:token"    => "reset_password#reset_token", as: 'reset_token'
  get  "password/reset"           => "reset_password#index"
  post "password/reset"           => "reset_password#save"



  #
  # AUTHENTICATION
  #
  
  resources :access_tokens, only: [:index, :destroy]
  match  "sign_out" => "sign_out#sign_out", via: [:get, :post, :head, :put, :delete]

  #
  # LOCALE
  #
  get  'locale' => 'locale#index'
  post 'locale' => 'locale#update'



  #
  # MASTER
  #

  namespace "master" do
    get '' => 'root#index'
    # impersonation
      get  'impersonate' => 'impersonation#destroy'
      post 'impersonate' => 'impersonation#create'
  end



end
