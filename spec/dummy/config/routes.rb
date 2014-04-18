Rails.application.routes.draw do

  root to: 'welcome#index'
  mount Hello::Engine => "/hello"
end
