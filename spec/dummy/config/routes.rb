Rails.application.routes.draw do

  get 'my_areas/guest_page'
  get 'my_areas/authenticated_page'
  get 'my_areas/novice_page'
  get 'my_areas/user_page'
  get 'my_areas/webmaster_page'
  get 'my_areas/non_webmaster_page'

  get  'novice' => 'novice#index'
  post 'novice' => 'novice#continue'
    
  resources :users, only: [:index, :show]

  root to: 'root#index'
  mount Hello::Engine => "/hello"
end
