Hello::Engine.routes.draw do
  



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
    get  "sign_up/welcome" => "registration#sign_up_welcome"

    # sign in
    get  "sign_in"         => "registration#sign_in"
    post "sign_in"         => "registration#authenticate"
    get  "sign_in/welcome" => "registration#sign_in_welcome"

    # forgot
    get  "forgot"         => "registration#forgot"
    post "forgot"         => "registration#ask"
    get  "forgot/welcome" => "registration#forgot_welcome"
    
    # reset
    get  "reset/token/:token" => "registration#reset_token", as: 'reset_token'
    get  "reset"              => "registration#reset"
    post "reset"              => "registration#save"

  end






end
