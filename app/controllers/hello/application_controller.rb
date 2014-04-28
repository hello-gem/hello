class Hello::ApplicationController < ApplicationController
  include BeforeActions::Controller

  puts "there should be authorization for these controllers"
end
