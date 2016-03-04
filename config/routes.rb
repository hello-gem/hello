Hello::Engine.routes.draw do
  root 'root#index'

  #
  # REGISTRATION
  #

  get 'sign_up' => 'email_sign_up#index'
  post 'sign_up' => 'email_sign_up#create'
  get 'sign_up/widget'  => 'email_sign_up#widget'

  #
  # AUTHENTICATION
  #

  resources :sessions, only: [:index, :new, :show, :destroy]

  get 'sign_out' => 'sessions#sign_out'

  get 'sign_in'         => 'email_sign_in#index'
  post 'sign_in' => 'email_sign_in#authenticate'

  get 'sudo_mode' => 'sudo_mode#form'
  patch 'sudo_mode' => 'sudo_mode#authenticate'
  get 'sudo_mode/expire' => 'sudo_mode#expire'

  #
  # MANAGEMENT
  #

  resources :accesses, only: [:index, :destroy]

  resource :current_user, only: [:show, :update]

  get 'cancel_account' => 'cancel_account#index'
  post 'cancel_account' => 'cancel_account#cancel'

  get 'locale' => 'locale#index'
  post 'locale' => 'locale#update'

  resources :emails, only: [:index, :create, :destroy] do
    member do
      post 'deliver'
      get 'confirm/:token' => 'confirm_emails#confirm', as: 'confirm'
    end
    collection do
      get 'expired_confirmation_token' => 'confirm_emails#expired_confirmation_token'
    end
  end

  resources :passwords, only: [:index, :show, :update] do
    collection do
      get 'forgot' => 'forgot_password#index'
      post 'forgot' => 'forgot_password#forgot'
    end
    member do
      scope '/reset/:user_id/:token' do
        get '/' => 'reset_password#index', as: 'reset'
        post '/' => 'reset_password#update', as: nil
      end
    end
  end

end
