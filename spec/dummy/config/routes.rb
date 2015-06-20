Rails.application.routes.draw do

  get 'my_areas/guest_page'
  get 'my_areas/authenticated_page'
  get 'my_areas/novice_page'
  get 'my_areas/user_page'
  get 'my_areas/master_page'
  get 'my_areas/non_master_page'

  get  'novice' => 'novice#index'
  post 'novice' => 'novice#continue'
    
  get 'profile/:username' => 'profile#profile', as: 'profile'
  resources :users, only: [:index, :show]

  root "welcome#index"
  mount Hello::Engine => "/hello"
end
