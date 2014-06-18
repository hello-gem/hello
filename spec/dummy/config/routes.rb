Rails.application.routes.draw do

  resources :users, only: [:index, :show]

  root to: redirect('/hello') # TODO: change this
  mount Hello::Engine => "/hello"
end
