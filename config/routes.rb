Hello::Engine.routes.draw do
  





  namespace :classic_registration do
  get 'reset_password/token'
  end

  namespace :classic_registration do
  get 'reset_password/index'
  end

  namespace :classic_registration do
  get 'reset_password/save'
  end

  namespace :classic_registration do
  get 'reset_password/done'
  end

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

  resources :credentials, only: [] do
    member do
      get  "confirm"              => "confirm_credential#confirm"
      post "confirm"              => "confirm_credential#deliver"
      get  "confirm/token/:token" => "confirm_credential#confirm_token", as: 'confirm_token'
      get  "confirm/done"         => "confirm_credential#done"
      get  "confirm/expired"      => "confirm_credential#expired"
    end
  end


  # classic registration
    # sign up
    get  "sign_up"         => "classic_registration/sign_up#index"
    post "sign_up"         => "classic_registration/sign_up#create"

    # sign in
    get  "sign_in"         => "classic_registration/sign_in#index"
    post "sign_in"         => "classic_registration/sign_in#authenticate"
    get  "authenticated"   => "classic_registration/sign_in#authenticated"

    # forgot
    get  "password/forgot"          => "classic_registration/forgot_password#index"
    post "password/forgot"          => "classic_registration/forgot_password#remember"
    get  "password/remembered"      => "classic_registration/forgot_password#remembered"

    # reset
    get  "password/reset/done"      => "classic_registration/reset_password#done"
    get  "password/reset/:token"    => "classic_registration/reset_password#reset_token", as: 'reset_token'
    get  "password/reset"           => "classic_registration/reset_password#index"
    post "password/reset"           => "classic_registration/reset_password#save"





end
