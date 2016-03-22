Rails.application.routes.draw do
  get 'middleware/bad_kitty', constraints: -> (request) { request.env['hello'].signed_in? }

  get 'my_areas/guest_page'
  get 'my_areas/authenticated_page'
  get 'my_areas/onboarding_page'
  get 'my_areas/user_page'
  get 'my_areas/webmaster_page'
  get 'my_areas/non_webmaster_page'

  get 'onboarding' => 'onboarding#index'
  post 'onboarding' => 'onboarding#continue'

  resources :users, only: [:index, :show] do
    collection do
      get 'list'
    end
    member do
      post 'impersonate'
    end
  end

  root to: 'root#index'
  mount Hello::Engine => '/hello'
  get '/hello/sign_out' => 'hello/sessions#sign_out'
end
