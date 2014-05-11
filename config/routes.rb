Hello::Engine.routes.draw do
  



  resources :sessions, only: [:index, :show]

  root "welcome#index"

  get  "sign_out" => "welcome#sign_out"

  # editing profile
    # user
    get   'user' => "user#edit"
    patch 'user' => "user#update"

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

  end






end
