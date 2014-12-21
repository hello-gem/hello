Rails.application.routes.draw do

  
  get  'novice' => 'novice#index'
  post 'novice' => 'novice#continue'
    
  get 'profile/:username' => 'profile#profile', as: 'profile'
  resources :users, only: [:index, :show]

  root "welcome#index"
  mount Hello::Engine => "/hello"
end
