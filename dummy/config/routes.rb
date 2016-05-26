Rails.application.routes.draw do

  get  'oauth2/' => 'oauth2#index'
  get  'auth/facebook/callback' => 'oauth2#facebook'
  post 'auth/facebook/callback' => 'oauth2#facebook'




  get 'middleware/bad_kitty', constraints: -> (request) { request.env['hello'].signed_in? }

  get 'my_areas/guest_page'
  get 'my_areas/authenticated_page'
  get 'my_areas/onboarding_page'
  get 'my_areas/user_page'
  get 'my_areas/webmaster_page'
  get 'my_areas/non_webmaster_page'

  get 'onboarding' => 'onboarding#index'
  post 'onboarding' => 'onboarding#continue'

  resources :users, only: [:index, :show, :new, :create] do
    collection do
      get 'list'
    end
    member do
      post 'impersonate'
    end
  end

  root to: 'root#index'
  mount Hello::Engine => '/hello'
  get '/hello/sign_out' => 'hello/authentication/sessions#sign_out'
end
