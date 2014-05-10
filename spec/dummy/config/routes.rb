Rails.application.routes.draw do

  root to: redirect('/hello') # TODO: change this
  mount Hello::Engine => "/hello"
end
