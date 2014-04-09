Rails.application.routes.draw do

  mount Hello::Engine => "/hello"
end
