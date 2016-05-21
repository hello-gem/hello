Hello::Engine.routes.draw do
  root 'root#index'

  #
  # REGISTRATION
  #
  scope module: 'registration' do
    get 'sign_up' => 'classic_sign_up#index'
    post 'sign_up' => 'classic_sign_up#create'
    get 'sign_up/widget' => 'classic_sign_up#widget'
    match 'sign_up/disabled' => 'classic_sign_up#disabled', via: [:get, :post]
  end

  #
  # AUTHENTICATION
  #
  scope module: 'authentication' do
    resources :sessions, only: [:index, :new, :show, :destroy]
    delete 'sign_out' => 'sessions#sign_out'

    get  'sign_in' => 'classic_sign_in#index'
    post 'sign_in' => 'classic_sign_in#authenticate'

    get 'sudo_mode' => 'sudo_mode#form'
    patch 'sudo_mode' => 'sudo_mode#authenticate'
    get 'sudo_mode/expire' => 'sudo_mode#expire'
  end

  #
  # MANAGEMENT
  #
  scope module: 'management' do
    resources :accesses, only: [:index, :destroy]

    resource :profile, only: [:show, :update]

    get 'cancel_account' => 'cancel_account#index'
    post 'cancel_account' => 'cancel_account#cancel'

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

  #
  # INTERNATIONALIZATION
  #
  scope module: 'internationalization' do
    get 'locale' => 'locale#index'
    post 'locale' => 'locale#update'
  end

end
