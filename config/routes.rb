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
  resource :current_user, only: [:show, :update]

  get   'sudo_mode'        => 'sudo_mode#form'
  patch 'sudo_mode'        => 'sudo_mode#authenticate'
  get   'sudo_mode/expire' => 'sudo_mode#expire'

  get  'deactivation' => 'deactivation#index'
  post 'deactivation' => 'deactivation#deactivate'


  #
  # PASSWORD MANAGEMENT
  #

  get   'password' => "password#edit"
  patch 'password' => "password#update"

  get  "password/forgot"     => "forgot_password#index"
  post "password/forgot"     => "forgot_password#remember"
  get  "password/remembered" => "forgot_password#remembered"

  get  "password/reset/:token"    => "reset_password#reset_token", as: 'reset_token'
  get  "password/reset"           => "reset_password#index"
  post "password/reset"           => "reset_password#save"



  #
  # AUTHENTICATION
  #
  
  resources :accesses, only: [:index, :destroy]
  match  "sign_out" => "sign_out#sign_out", via: [:get, :post, :head, :put, :delete]
  
  get    "switch_users"     => "switch_users#index"
  get    "switch_users/:id" => "switch_users#switch", as: 'switch_user'
  delete "switch_users/:id" => "switch_users#forget"

  #
  # LOCALE
  #
  get  'locale' => 'locale#index'
  post 'locale' => 'locale#update'



  #
  # WEBMASTER
  #

  namespace "webmaster" do
    get '' => 'root#index'
    resources :users, only: [:index] do
      member do
        post 'impersonate'
      end
      collection do
        get 'impersonate_back'
      end
    end
  end



end
