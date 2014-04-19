Hello::Engine.routes.draw do
  


  root "welcome#index"

  get  "sign_out" => "welcome#sign_out"

  # editing profile
    # user
    get   'user' => "user#edit"
    patch 'user' => "user#update"


  # sign up
    # password
      # sign up
      get  "password/sign_up"
      post "password/sign_up"         => "password#create"
      get  "password/sign_up/welcome" => "password#sign_up_welcome"

      # sign in
      get  "password/sign_in"
      post "password/sign_in"         => "password#authenticate"
      get  "password/sign_in/welcome" => "password#sign_in_welcome"

      # forgot
      get  "password/forgot"
      post "password/forgot"         => "password#ask"
      get  "password/forgot/welcome" => "password#forgot_welcome"
      
      # reset
      get  "password/reset"
      post "password/reset"          => "password#save"
      get  "password/reset/welcome"  => "password#reset_welcome"







end
